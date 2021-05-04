//
//  VenueEntity.swift
//  NordeaExercise
//
//  Created by Laitarenko Roman on 30.4.2021.
//

import Foundation

struct VenueEntity {
    let name: String
    let address: String?
    let distance: Int?
}

extension VenueEntity: Decodable {
    enum CodingKeys: CodingKey {
        case name, location
    }
    enum LocationCodingKeys: CodingKey {
        case address, distance
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let locationContainer = try container.nestedContainer(keyedBy: LocationCodingKeys.self, forKey: .location)

        self.name = try container.decode(String.self, forKey: .name)
        self.distance = try locationContainer.decodeIfPresent(Int.self, forKey: .distance)
        self.address = try locationContainer.decodeIfPresent(String.self, forKey: .address)
    }

}
