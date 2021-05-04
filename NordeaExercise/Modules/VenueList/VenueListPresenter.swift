//
//  VenueListPresenter.swift
//  NordeaExercise
//
//  Created by Laitarenko Roman on 30.4.2021.
//

import Foundation
import Combine

protocol VenueListPresenterProtocol: AnyObject {
    func viewIsReady()
    func searchTextDidChange(_ searchText: String?)
}

final class VenueListPresenter: NSObject, VenueListPresenterProtocol {
    private weak var view: VenueListViewProtocol!
    private let venuesQuery: VenueSearchQueryProtocol
    private let locationService: LocationServiceProtocol
    private let viewModelFactory: VenueListViewModelFactoryProtocol

    private var searchTextSubject = PassthroughSubject<String?, Never>()
    private var cancellables = Set<AnyCancellable>()
    private var searchUpdateCancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }

    // MARK: - Lifecycle

    init(
        view: VenueListViewProtocol,
        venuesQuery: VenueSearchQueryProtocol,
        locationService: LocationServiceProtocol,
        viewModelFactory: VenueListViewModelFactoryProtocol
    ) {
        self.venuesQuery = venuesQuery
        self.locationService = locationService
        self.view = view
        self.viewModelFactory = viewModelFactory
        super.init()

        searchTextSubject
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                self?.debouncedSearchTextDidChange(searchText)
            }
            .store(in: &cancellables)
    }

    // MARK: - VenueListPresenterProtocol

    func viewIsReady() {
        view.setupInitialState()
        requestVenuesFor(query: nil).store(in: &cancellables)
    }

    func searchTextDidChange(_ searchText: String?) {
        searchTextSubject.send(searchText)
    }

    // MARK: - Private

    private func debouncedSearchTextDidChange(_ searchText: String?) {
        searchUpdateCancellable = requestVenuesFor(query: searchText?.trimmingCharacters(in: .whitespaces))
    }

    private func requestVenuesFor(query: String?) -> AnyCancellable {
        let venuesQuery = venuesQuery
        return locationService.currentLocation()
            .removeDuplicates()
            .flatMap { location -> AnyPublisher<[VenueEntity], Error> in
                return venuesQuery.run(
                    query: query,
                    latitude: location.coordinate.latitude,
                    longitude: location.coordinate.longitude
                )
            }
            .retry(3)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in

                if case Subscribers.Completion.failure(let error) = result {
                    self?.view.showError(error)
                }
            } receiveValue: { [weak self] value in
                guard let self = self else {
                    return
                }
                let items = self.viewModelFactory.items(from: value)

                self.view.update(with: items)
            }
    }
}
