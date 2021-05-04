//
//  VenueListAssembly.swift
//  NordeaExercise
//
//  Created by Laitarenko Roman on 4.5.2021.
//

import UIKit
import CoreLocation

final class VenueListAssembly {
    static func configure() -> UIViewController {
        let venueListVC = UIStoryboard(name: "VenueList", bundle: nil)
            .instantiateInitialViewController() as! VenueListView
        let venueSearchQuery = VenueSearchQuery()
        let locationService = LocationService(locationManager: CLLocationManager())
        let viewModelFactory = VenueListViewModelFactory()
        let venueListPresenter = VenueListPresenter(
            view: venueListVC,
            venuesQuery: venueSearchQuery,
            locationService: locationService,
            viewModelFactory: viewModelFactory
        )

        venueListVC.presenter = venueListPresenter

        return venueListVC
    }
}
