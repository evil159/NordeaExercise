//
//  VenueListViewModelFactoryTests.swift
//  NordeaExerciseTests
//
//  Created by Laitarenko Roman on 4.5.2021.
//

import Foundation
import XCTest

@testable import NordeaExercise

final class VenueListViewModelFactoryTests: XCTestCase {
    var viewModelFactory: VenueListViewModelFactory!

    override func setUp() {
        super.setUp()

        viewModelFactory = VenueListViewModelFactory()
    }

    func testFactory_ReturnsVenuesViewModels() {
        // given
        let venue = VenueEntity(name: "entityName", address: "entityAddress", distance: 42)
        let venueEntities = Array(repeating: venue, count: 3)

        // when
        let items = viewModelFactory.items(from: venueEntities)

        // then
        XCTAssertEqual(venueEntities.count, items.count)

        for i in 0..<venueEntities.count {
            guard let viewModel = items[i] as? SubtitleItemViewModel else {
                XCTFail("Wrong model type")
                return
            }

            XCTAssertNotNil(viewModel.title)
            XCTAssertNotNil(viewModel.description)
            XCTAssertNotNil(viewModel.infoText)
        }
    }
}
