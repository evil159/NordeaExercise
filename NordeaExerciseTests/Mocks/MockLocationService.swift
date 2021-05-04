//
//  MockLocationService.swift
//  NordeaExerciseTests
//
//  Created by Laitarenko Roman on 2.5.2021.
//

import Foundation
import Combine
import CoreLocation

@testable import NordeaExercise

final class MockLocationService: LocationServiceProtocol {
    var getCurrentLocationCalled = false
    var getCurrentLocationCalledCount = 0

    func currentLocation() -> AnyPublisher<CLLocation, Never> {
        getCurrentLocationCalled = true
        getCurrentLocationCalledCount += 1
        
        return Just(CLLocation()).eraseToAnyPublisher()
    }
}
