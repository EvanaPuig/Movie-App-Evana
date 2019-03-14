//
//  GeneralModel.swift
//  MovieAppEvana
//
//  Created by Evana Margain on 3/1/19.
//  Copyright © 2019 Evisoft. All rights reserved.
//

import Foundation
import CoreData

class Movie: NSManagedObject, Codable {
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdrop_path
        case belongs_to_collection
        case budget
        case genres
        case homepage
        case id
        case imdb_id
        case original_language
        case original_title
        case overview
        case popularity
        case poster_path
        case production_companies
        case production_countries
        case release_date
        case revenue
        case runtime
        case spoken_languages
        case status
        case tagline
        case title
        case video
        case vote_average
        case vote_count
        case image_formatted_url
    }
    
    
    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }
    
    // MARK: - Core Data Managed Object
    @NSManaged var adult: Bool
    @NSManaged var backdrop_path: String?
    @NSManaged var belongs_to_collection: Collection?
    @NSManaged var budget: Int16
    @NSManaged var genres: Set<Genre>?
    @NSManaged var homepage: String?
    @NSManaged var id: Int32
    @NSManaged var imdb_id: String?
    @NSManaged var original_language: String?
    @NSManaged var original_title: String?
    @NSManaged var overview: String?
    @NSManaged var popularity: Double
    @NSManaged var poster_path: String?
    @NSManaged var production_companies: Array<ProductionCompany>?
    @NSManaged var production_countries: Array<ProductionCountries>?
    @NSManaged var release_date: String?
    @NSManaged var revenue: Int16
    @NSManaged var runtime: Int16
    @NSManaged var spoken_languages: Array<SpokenLanguages>?
    @NSManaged var status: String?
    @NSManaged var tagline: String?
    @NSManaged var title: String?
    @NSManaged var video: Bool
    @NSManaged var vote_average: Double
    @NSManaged var vote_count: Int16
    @NSManaged var image_formatted_url: String?
    
    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Movie", in: managedObjectContext) else {
                fatalError("Failed to decode Movie")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.adult = try container.decodeIfPresent(Bool.self, forKey: .adult) ?? false
        self.backdrop_path = try container.decodeIfPresent(String.self, forKey: .backdrop_path)
        self.belongs_to_collection = try container.decodeIfPresent(Collection.self, forKey: .belongs_to_collection)
        self.budget = Int16(try container.decodeIfPresent(Int.self, forKey: .budget) ?? 0)
        self.genres = try container.decodeIfPresent(Set<Genre>.self, forKey: .genres)
        self.homepage = try container.decodeIfPresent(String.self, forKey: .homepage)
        self.id = Int32(try container.decodeIfPresent(Int.self, forKey: .id) ?? 0)
        self.imdb_id = try container.decodeIfPresent(String.self, forKey: .imdb_id)
        self.original_language = try container.decodeIfPresent(String.self, forKey: .original_language)
        self.original_title = try container.decodeIfPresent(String.self, forKey: .original_title)
        self.overview = try container.decodeIfPresent(String.self, forKey: .overview)
        self.popularity = try container.decodeIfPresent(Double.self, forKey: .popularity) ?? 0.0
        self.poster_path = try container.decodeIfPresent(String.self, forKey: .poster_path)
        self.production_companies = try container.decodeIfPresent([ProductionCompany].self, forKey: .production_companies)
        self.production_countries = try container.decodeIfPresent([ProductionCountries].self, forKey: .production_countries)
        self.release_date = try container.decodeIfPresent(String.self, forKey: .release_date)
        self.revenue = Int16(try container.decodeIfPresent(Int.self, forKey: .revenue) ?? 0)
        self.runtime = Int16(try container.decodeIfPresent(Int.self, forKey: .runtime) ?? 0)
        self.spoken_languages = try container.decodeIfPresent([SpokenLanguages].self, forKey: .spoken_languages)
        self.status = (try container.decodeIfPresent(String.self, forKey: .status))
        self.tagline = (try container.decodeIfPresent(String.self, forKey: .tagline))
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.video = try container.decodeIfPresent(Bool.self, forKey: .video) ?? false
        self.vote_average = try container.decodeIfPresent(Double.self, forKey: .vote_average) ?? 0.0
        self.vote_count = Int16(try container.decodeIfPresent(Int.self, forKey: .vote_count) ?? 0)
        self.image_formatted_url = (try container.decodeIfPresent(String.self, forKey: .image_formatted_url))
        
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(adult, forKey:CodingKeys.adult)
        try container.encode(backdrop_path, forKey: .backdrop_path)
        try container.encode(belongs_to_collection, forKey: .belongs_to_collection)
        try container.encode(budget, forKey: .budget)
        try container.encode(genres, forKey: .genres)
        try container.encode(homepage, forKey: .homepage)
        try container.encode(id, forKey: .id)
        try container.encode(imdb_id, forKey: .imdb_id)
        try container.encode(original_language, forKey: .original_language)
        try container.encode(original_title, forKey: .original_title)
        try container.encode(overview, forKey: .overview)
        try container.encode(popularity, forKey: .popularity)
        try container.encode(poster_path, forKey: .poster_path)
        try container.encode(production_companies, forKey: .production_companies)
        try container.encode(production_countries, forKey: .production_countries)
        try container.encode(release_date, forKey: .release_date)
        try container.encode(revenue, forKey: .revenue)
        try container.encode(runtime, forKey: .runtime)
        try container.encode(spoken_languages, forKey: .spoken_languages)
        try container.encode(status, forKey: .status)
        try container.encode(tagline, forKey: .tagline)
        try container.encode(title, forKey: .title)
        try container.encode(video, forKey: .video)
        try container.encode(vote_average, forKey: .vote_average)
        try container.encode(vote_count, forKey: .vote_count)
        try container.encode(image_formatted_url, forKey: .image_formatted_url)
    }
}

public extension CodingUserInfoKey {
    // Helper property to retrieve the context
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}
