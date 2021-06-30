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
    let posterPath: String?
    let releaseDate: Date?
   
    let voteAverage: Double
    let voteCount: Int
    let productionCompanies:[ProducerCompany]?
    
    private enum CodingKeys: String, CodingKey {
        case id, title, overview, genres, homepage
        case backdropImage = "backdrop_path"
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case productionCompanies = "production_companies"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
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

struct MovieCredits: Decodable {
    let movieId: Int
    let cast: [Cast]
    
    private enum CodingKeys: String, CodingKey {
        case movieId = "id", cast
    }
}

struct Cast: Decodable{
    let name: String
    let profileImage: String?
    
    private enum CodingKeys: String, CodingKey {
        case name, profileImage="profile_path"
    }
}
