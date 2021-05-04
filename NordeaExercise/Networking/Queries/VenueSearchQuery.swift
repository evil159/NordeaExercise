//
//  VenueSearchQuery.swift
//  NordeaExercise
//
//  Created by Laitarenko Roman on 30.4.2021.
//

import Foundation
import Combine

protocol VenueSearchQueryProtocol: AnyObject {
    func run(query: String?, latitude: Double, longitude: Double) -> AnyPublisher<[VenueEntity], Error>
}

final class VenueSearchQuery: VenueSearchQueryProtocol {
    func run(query: String?, latitude: Double, longitude: Double) -> AnyPublisher<[VenueEntity], Error> {
        var components = URLComponents(string: "https://api.foursquare.com/v2/venues/search")
        components?.queryItems = [

            URLQueryItem(name: "ll", value: "\(latitude),\(longitude)"),
            URLQueryItem(name: "client_id", value: "CYEMKOM4OLTP5PHMOFVUJJAMWT5CH5G1JBCYREATW21XLLSZ"),
            URLQueryItem(name: "client_secret", value: "GYNP4URASNYRNRGXR5UEN2TGTKJHXY5FGSAXTIHXEUG1GYM2"),
            URLQueryItem(name: "v", value: "20210430")
        ]
        if let query = query {
            components?.queryItems?.append(URLQueryItem(name: "query", value: query))
        }
        return URLSession.shared.dataTaskPublisher(for: components!.url!)
            .map(\.data)
            .decode(type: VenueSearchResponse.self, decoder: JSONDecoder())
            .map(\VenueSearchResponse.response.venues)
            .eraseToAnyPublisher()
    }
}
