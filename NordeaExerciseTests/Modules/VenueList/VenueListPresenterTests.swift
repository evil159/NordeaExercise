//
//  VenueListPresenterTests.swift
//  NordeaExerciseTests
//
//  Created by Laitarenko Roman on 2.5.2021.
//

import XCTest

@testable import NordeaExercise

final class VenueListPresenterTests: XCTestCase {
    let mockView = MockVenueListView()
    let mockQuery = MockVenueSearchQuery()
    let mockLocationService = MockLocationService()
    let mockViewModelFactory = MockVenueListViewModelFactory()

    var presenter: VenueListPresenter!

    override func setUp() {
        super.setUp()

        presenter = VenueListPresenter(
            view: mockView,
            venuesQuery: mockQuery,
            locationService: mockLocationService,
            viewModelFactory: mockViewModelFactory
        )
    }

    func test_WhenViewIsReady_ShouldSetupView() {
        // when
        presenter.viewIsReady()

        // then
        assertMethodCall(mockView.setupInitialStateCalled)
    }

    func test_WhenViewIsReady_ShouldRequestVenues() {
        // when
        presenter.viewIsReady()

        // then
        assertMethodCall(mockQuery.runCalled)
    }

    func test_WhenSearchTextDidChange_ShouldRequestVenues() {
        // when
        presenter.searchTextDidChange("query")

        // then
        eventually(timeout: 1) {
            assertMethodCall(self.mockQuery.runCalled)
        }
    }

    func test_WhenSearchTextChangesFrequently_ShouldDebounceQuery() {
        // when
        presenter.searchTextDidChange("1")
        presenter.searchTextDidChange("2")
        presenter.searchTextDidChange("3")

        // then
        eventually(timeout: 1) {
            assertMethodCall(self.mockQuery.runCalled)
            assert(self.mockQuery.runCalledCount == 1)
        }
    }

    func test_WhenSearchTextDidChange_ShouldRequestLocation() {
        // when
        presenter.searchTextDidChange("query")

        // then
        eventually(timeout: 1) {
            assertMethodCall(self.mockLocationService.getCurrentLocationCalled)
        }
    }

    func test_WhenSearchTextDidChange_ShouldDebounceLocation() {
        // when
        presenter.searchTextDidChange("1")
        presenter.searchTextDidChange("2")
        presenter.searchTextDidChange("3")

        // then
        eventually(timeout: 1) {
            assertMethodCall(self.mockLocationService.getCurrentLocationCalled)
            assert(self.mockLocationService.getCurrentLocationCalledCount == 1)
        }
    }

    func test_WhenSearchError_ShouldShowError() {
        // given
        mockQuery.returnError = true

        // when
        presenter.searchTextDidChange("query")

        // then
        eventually(timeout: 1) {
            assertMethodCall(self.mockView.showErrorCalled)
        }
    }

    func test_WhenVenuesLoaded_ShouldUpdateView() {
        // when
        presenter.searchTextDidChange("query")

        // then
        eventually(timeout: 1) {
            assertMethodCall(self.mockViewModelFactory.itemsFromVenuesCalled)
            assertMethodCall(self.mockView.updateCalled)
        }
    }
}
