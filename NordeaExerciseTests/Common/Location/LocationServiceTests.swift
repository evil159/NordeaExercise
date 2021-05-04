//
//  LocationServiceTests.swift
//  NordeaExerciseTests
//
//  Created by Laitarenko Roman on 2.5.2021.
//

import XCTest
import CoreLocation
import Combine

@testable import NordeaExercise

final class LocationServiceTests: XCTestCase {
    let mockLocationManager = MockLocationManager()

    var locationService: LocationService!
    var cancellable: AnyCancellable?

    let location = CLLocation(
        coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        altitude: 0,
        horizontalAccuracy: 0,
        verticalAccuracy: 0,
        timestamp: Date().addingTimeInterval(-2 * 60 * 60 - 1)
    )

    override func setUp() {
        super.setUp()

        locationService = LocationService(locationManager: mockLocationManager)
    }

    func testCurrentLocation_WhenAuthorizationNotDetermined_ShouldRequestAuthorization() {
        // given
        mockLocationManager.authorizationStatus = .notDetermined

        // when
        _ = locationService.currentLocation()

        // then
        assertMethodCall(mockLocationManager.requestWhenInUseAuthorizationCalled)
    }

    func testCurrentLocation_WhenLocationIsEmpty_ShouldRequestLocation() {
        // given
        mockLocationManager.location = nil

        // when
        _ = locationService.currentLocation()

        // then
        assertMethodCall(mockLocationManager.requestLocationCalled)
    }

    func testCurrentLocation_WhenLocationIsExpired_ShouldRequestLocation() {
        // given
        mockLocationManager.location = location

        // when
        _ = locationService.currentLocation()

        // then
        assertMethodCall(mockLocationManager.requestLocationCalled)
    }

    func test_WhenAuthorizationGiven_ShouldRequestLocation() {
        // when
        mockLocationManager.delegate?.locationManagerDidChangeAuthorization?(CLLocationManager())

        // then
        assertMethodCall(mockLocationManager.requestLocationCalled)
    }

    func test_WhenLocationUpdate_ShouldSend() {
        // when
        mockLocationManager.delegate?.locationManager?(CLLocationManager(), didUpdateLocations: [location])

        // then
        var receivedLocation: CLLocation?
        cancellable = locationService.currentLocation()
            .sink { location in
                receivedLocation = location
            }

        eventually {
            XCTAssertEqual(self.location, receivedLocation)
        }
    }

    func test_WhenAuthorizationDenied_ShouldSendDefaultLocation() {
        // given
        let defaultLocation = CLLocation(latitude: 60.1684, longitude: 24.976)
        mockLocationManager.authorizationStatus = .denied

        // then
        var receivedLocation: CLLocation?
        cancellable = locationService.currentLocation()
            .sink { location in
                receivedLocation = defaultLocation
            }

        eventually {
            XCTAssertEqual(defaultLocation, receivedLocation)
        }
    }
}
