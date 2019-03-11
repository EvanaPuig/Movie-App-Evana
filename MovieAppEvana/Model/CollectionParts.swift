//
//  CollectionParts.swift
//  MovieAppEvana
//
//  Created by Evana Margain on 3/10/19.
//  Copyright © 2019 Evisoft. All rights reserved.
//

import Foundation
import CoreData

class CollectionParts: NSManagedObject, Codable{
    enum CodingKeys: String, CodingKey {
        case adult
        case backdrop_path
        case genre_ids
        case id
        case original_language
        case original_title
        case overview
        case release_date
        case poster_path
        case popularity
        case title
        case video
        case vote_average
        case vote_count
    }
    
    @NSManaged var adult: Bool
    @NSManaged var backdrop_path: String?
    @NSManaged var genre_ids: Array<Int>?
    @NSManaged var id: Int
    @NSManaged var original_language: String?
    @NSManaged var original_title: String?
    @NSManaged var overview: String?
    @NSManaged var release_date: String?
    @NSManaged var poster_path: String?
    @NSManaged var popularity: Int
    @NSManaged var title: String?
    @NSManaged var video: Bool
    @NSManaged var vote_average: Int
    @NSManaged var vote_count: Int
    
    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Collection Parts", in: managedObjectContext) else {
                fatalError("Failed to decode Collection Parts")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.adult = ((try container.decodeIfPresent(Bool.self, forKey: .adult)) != nil)
        self.backdrop_path = try container.decodeIfPresent(String.self, forKey: .backdrop_path)
        self.genre_ids = try container .decodeIfPresent([Int].self, forKey: .genre_ids)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        self.original_language = try container.decodeIfPresent(String.self, forKey: .original_language)
        self.original_title = try container.decodeIfPresent(String.self, forKey: .original_title)
        self.overview = try container.decodeIfPresent(String.self, forKey: .overview)
        self.release_date = try container.decodeIfPresent(String.self, forKey: .release_date)
        self.poster_path = try container.decodeIfPresent(String.self, forKey: .poster_path)
        self.popularity = try container.decodeIfPresent(Int.self, forKey: .popularity) ?? 0
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.video = ((try container.decodeIfPresent(Bool.self, forKey: .video)) != nil)
        self.vote_average = try container.decodeIfPresent(Int.self, forKey: .vote_average) ?? 0
        self.vote_count = try container.decodeIfPresent(Int.self, forKey: .vote_count) ?? 0
        
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(adult, forKey:CodingKeys.adult)
        try container.encode(backdrop_path, forKey:CodingKeys.backdrop_path)
        try container.encode(genre_ids, forKey: CodingKeys.genre_ids)
        try container.encode(id, forKey: CodingKeys.id)
        try container.encode(original_language, forKey: CodingKeys.original_language)
        try container.encode(original_title, forKey: CodingKeys.original_title)
        try container.encode(overview, forKey: CodingKeys.overview)
        try container.encode(release_date, forKey: CodingKeys.release_date)
        try container.encode(poster_path, forKey: CodingKeys.poster_path)
        try container.encode(popularity, forKey: CodingKeys.popularity)
        try container.encode(title, forKey: CodingKeys.title)
        try container.encode(video, forKey: CodingKeys.video)
        try container.encode(vote_average, forKey: CodingKeys.vote_average)
        try container.encode(vote_count, forKey: CodingKeys.vote_count)
    }
}
