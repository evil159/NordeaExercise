//
//  MockVenueSearchQuery.swift
//  NordeaExerciseTests
//
//  Created by Laitarenko Roman on 2.5.2021.
//

import Foundation
import Combine

@testable import NordeaExercise

final class MockVenueSearchQuery: VenueSearchQueryProtocol {
    enum QueryError: Swift.Error {
        case test
    }
    var runCalled = false
    var runCalledCount = 0
    var returnError = false

    func run(query: String?, latitude: Double, longitude: Double) -> AnyPublisher<[VenueEntity], Error> {
        runCalled = true
        runCalledCount += 1

        guard !returnError else {
            return Fail(error: QueryError.test).eraseToAnyPublisher()
        }

        return Just([])
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
