//
//  ViewController.swift
//  NordeaExercise
//
//  Created by Laitarenko Roman on 30.4.2021.
//

import UIKit

protocol VenueListViewProtocol: UpdateListProtocol {
    func setupInitialState()
    func showError(_ error: Error)
}

final class VenueListView: BaseTableViewController, VenueListViewProtocol {

    var presenter: VenueListPresenterProtocol!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewIsReady()
    }

    // MARK: - VenueListViewProtocol

    func setupInitialState() {
        let searchController = UISearchController(searchResultsController: nil)

        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false

        navigationItem.searchController = searchController
    }

    func showError(_ error: Error) {
        let alert = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))

        show(alert, sender: self)
    }
}

// MARK: - UISearchResultsUpdating

extension VenueListView: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        presenter.searchTextDidChange(searchController.searchBar.text)
    }
}

