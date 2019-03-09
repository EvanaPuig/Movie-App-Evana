//
//  GeneralModel.swift
//  MovieAppEvana
//
//  Created by Evana Margain on 3/1/19.
//  Copyright © 2019 Evisoft. All rights reserved.
//

import Foundation

struct Movie: Codable {
    var adult: Bool?
    var backdrop_path: String?
    var belongs_to_collection: Collection?
    var budget: Int?
    var genres: Array<Genre>?
    var homepage: String?
    var id: Int?
    var imdb_id: String?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var popularity: Double?
    var poster_path: String?
    var production_companies: Array<ProductionCompany>?
    var production_countries: Array<ProductionCountries>?
    var release_date: String?
    var revenue: Int?
    var runtime: Int?
    var spoken_languages: Array<SpokenLanguages>?
    var status: String?
    var tagline: String?
    var title: String?
    var video: Bool?
    var vote_average: Double?
    var vote_count: Int?
    var image_formatted_url: String?
}

