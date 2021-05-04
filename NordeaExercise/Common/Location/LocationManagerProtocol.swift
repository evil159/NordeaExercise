//
//  LocationServiceProtocol.swift
//  NordeaExercise
//
//  Created by Laitarenko Roman on 2.5.2021.
//

import Foundation
import CoreLocation

protocol LocationManagerProtocol: AnyObject {
    var delegate: CLLocationManagerDelegate? { get set }
    var location: CLLocation? { get }
    var authorizationStatus: CLAuthorizationStatus { get }

    func requestWhenInUseAuthorization()
    func requestLocation()
}

extension CLLocationManager: LocationManagerProtocol { }
