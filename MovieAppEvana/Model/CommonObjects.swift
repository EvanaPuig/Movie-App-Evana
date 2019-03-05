//
//  CommonObjects.swift
//  MovieAppEvana
//
//  Created by Evana Margain on 3/4/19.
//  Copyright © 2019 Evisoft. All rights reserved.
//

import Foundation

struct Collection: Codable {
    var id: Int?
    var name: String?
    var overview: String?
    var poster_path: String?
    var backdrop_path: String?
    var parts: Array<CollectionParts>?
}

struct CollectionParts: Codable{
    var adult: Bool?
    var backdrop_path: String?
    var genre_ids: Array<Int>?
    var id: Int?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var release_date: String?
    var poster_path: String?
    var popularity: Int?
    var title: String?
    var video: Bool?
    var vote_average: Int?
    var vote_count: Int?
}

struct Genre: Codable {
    var id: Int?
    var name: String?
}

struct ProductionCompany: Codable {
    var name: String?
    var id: Int?
    var logo_path: String?
    var origin_country: String?
}

struct ProductionCountries: Codable {
    var iso_3166_1: String?
    var name: String?
}

struct SpokenLanguages: Codable {
    var iso_639_1: String?
    var name: String?
}
