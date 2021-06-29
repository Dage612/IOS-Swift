//
//  MovieDetail.swift
//  Rest API
//
//  Created by Olman Mora on 6/24/21.
//  Copyright © 2021 Niso. All rights reserved.
//

import Foundation

struct MovieDetail : Decodable {
    let id: Int
    let backdropImage: String?
    let genres: [Genre]?
    let homepage: String?
    let title: String
    let overview: String
   
    let voteAverage: Double
    let voteCount: Int
    let productionCompanies:[ProducerCompany]?
    
    private enum CodingKeys: String, CodingKey {
        case id, title, overview, genres, homepage
        case backdropImage = "backdrop_path"
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case productionCompanies = "production_companies"
    }
}

struct Genre : Decodable {
    let id: Int
    let name: String
    private enum CodingKeys: String, CodingKey {
        case id, name
    }
}

struct ProducerCompany : Decodable{
    let id: Int
    let name: String
    let logoPath: String?
    
    private enum CodingKeys: String, CodingKey {
        case id, name, logoPath = "logo_path"
    }
}
