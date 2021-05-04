//
//  MockLocationManager.swift
//  NordeaExerciseTests
//
//  Created by Laitarenko Roman on 2.5.2021.
//

import XCTest
import Combine
import CoreLocation

@testable import NordeaExercise

final class MockLocationManager: LocationManagerProtocol {
    weak var delegate: CLLocationManagerDelegate?

    var location: CLLocation?
    var authorizationStatus: CLAuthorizationStatus = .notDetermined

    var requestWhenInUseAuthorizationCalled = false
    var requestLocationCalled = false

    func requestWhenInUseAuthorization() {
        requestWhenInUseAuthorizationCalled = true
    }

    func requestLocation() {
        requestLocationCalled = true
    }
}
