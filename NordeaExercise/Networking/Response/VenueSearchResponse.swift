//
//  VenueSearchResponse.swift
//  NordeaExercise
//
//  Created by Laitarenko Roman on 30.4.2021.
//

import Foundation

struct VenueSearchResponse: Decodable {
    struct Response: Decodable {
        let venues: [VenueEntity]
    }
    let response: Response
}
