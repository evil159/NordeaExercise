//
//  LocationService.swift
//  NordeaExercise
//
//  Created by Laitarenko Roman on 30.4.2021.
//

import Foundation
import Combine
import CoreLocation

protocol LocationServiceProtocol: AnyObject {
    func currentLocation() -> AnyPublisher<CLLocation, Never>
}

final class LocationService: NSObject, LocationServiceProtocol {
    private let locationPublisher = CurrentValueSubject<CLLocation, Never>(
        CLLocation(latitude: 60.1684, longitude: 24.976)
    )
    private let locationManager: LocationManagerProtocol

    init(locationManager: LocationManagerProtocol) {
        self.locationManager = locationManager
        super.init()
        self.locationManager.delegate = self
    }

    func currentLocation() -> AnyPublisher<CLLocation, Never> {
        requestAuthorizationIfNeeded()
        requestLocationUpdateIfNeeded()
        return locationPublisher.eraseToAnyPublisher()
    }

    private func requestAuthorizationIfNeeded() {
        guard locationManager.authorizationStatus == .notDetermined else {
            return
        }

        locationManager.requestWhenInUseAuthorization()
    }

    private func requestLocationUpdateIfNeeded() {
        guard let location = locationManager.location else {
            locationManager.requestLocation()
            return

        }
        let twoHoursBefore = Date().addingTimeInterval(-2 * 60 * 60)

        if location.timestamp > twoHoursBefore {
            locationPublisher.value = location
        } else {
            locationManager.requestLocation()
        }
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            requestLocationUpdateIfNeeded()
        default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }

        locationPublisher.value = location
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}
