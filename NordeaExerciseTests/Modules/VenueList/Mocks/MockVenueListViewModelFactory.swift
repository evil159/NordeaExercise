//
//  MockVenueListViewModelFactory.swift
//  NordeaExerciseTests
//
//  Created by Laitarenko Roman on 4.5.2021.
//

import Foundation

@testable import NordeaExercise

final class MockVenueListViewModelFactory: VenueListViewModelFactoryProtocol {
    var itemsFromVenuesCalled = false

    func items(from venues: [VenueEntity]) -> [ListItemViewModel] {
        itemsFromVenuesCalled = true
        return []
    }
}
