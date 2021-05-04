//
//  VenueListViewModelFactory.swift
//  NordeaExercise
//
//  Created by Laitarenko Roman on 2.5.2021.
//

import Foundation

protocol VenueListViewModelFactoryProtocol: AnyObject {
    func items(from venues: [VenueEntity]) -> [ListItemViewModel]
}

final class VenueListViewModelFactory: VenueListViewModelFactoryProtocol {
    private lazy var distanceFormatter: MeasurementFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .none
        let distanceFormatter = MeasurementFormatter()
        distanceFormatter.unitStyle = .medium
        distanceFormatter.unitOptions = .naturalScale
        distanceFormatter.numberFormatter = numberFormatter
        return distanceFormatter
    }()

    // MARK: - VenueListViewModelFactoryProtocol

    func items(from venues: [VenueEntity]) -> [ListItemViewModel] {
        return venues.map { venue -> ListItemViewModel in
            let formattedDistance = formattedDistance(from: venue.distance)

            return SubtitleItemViewModel(
                title: venue.name,
                description: venue.address,
                infoText: formattedDistance
            )
        }
    }

    // MARK: - Private

    private func formattedDistance(from distance: Int?) -> String? {
        return distance
            .map { (distance: Int) -> Measurement in
                Measurement(value: Double(distance), unit: UnitLength.meters)
            }
            .map(distanceFormatter.string(from:))
    }
}
