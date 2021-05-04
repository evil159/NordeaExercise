//
//  MockVenueListView.swift
//  NordeaExerciseTests
//
//  Created by Laitarenko Roman on 2.5.2021.
//

import Foundation

@testable import NordeaExercise

final class MockVenueListView: VenueListViewProtocol {
    var updateCalled = false
    var setupInitialStateCalled = false
    var showErrorCalled = false

    func setupInitialState() {
        setupInitialStateCalled = true
    }

    func update(with items: [ListItemViewModel]) {
        updateCalled = true
    }

    func showError(_ error: Error) {
        showErrorCalled = true
    }
}
