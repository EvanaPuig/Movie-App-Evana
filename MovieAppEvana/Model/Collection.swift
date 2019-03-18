//
//  CommonObjects.swift
//  MovieAppEvana
//
//  Created by Evana Margain on 3/4/19.
//  Copyright © 2019 Evisoft. All rights reserved.
//

import Foundation
import CoreData

class Collection: NSManagedObject, Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case overview
        case poster_path
        case backdrop_path
        case parts
    }
    
    // MARK: - Core Data Managed Object
    @NSManaged var id: Int
    @NSManaged var name: String?
    @NSManaged var overview: String?
    @NSManaged var poster_path: String?
    @NSManaged var backdrop_path: String?
    @NSManaged var parts: Array<CollectionParts>?
    
    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Collection", in: managedObjectContext) else {
                fatalError("Failed to decode Collection")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.overview = try container.decodeIfPresent(String.self, forKey: .overview)
        self.poster_path = try container.decodeIfPresent(String.self, forKey: .poster_path)
        self.backdrop_path = try container.decodeIfPresent(String.self, forKey: .backdrop_path)
        self.parts = try container.decodeIfPresent([CollectionParts].self, forKey: .parts)
        
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey:CodingKeys.id)
        try container.encode(name, forKey:CodingKeys.name)
        try container.encode(overview, forKey:CodingKeys.overview)
        try container.encode(poster_path, forKey:CodingKeys.poster_path)
        try container.encode(backdrop_path, forKey:CodingKeys.backdrop_path)
        try container.encode(parts, forKey:CodingKeys.parts)
    }
}




