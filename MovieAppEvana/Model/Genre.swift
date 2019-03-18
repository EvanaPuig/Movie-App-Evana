//
//  Genre.swift
//  MovieAppEvana
//
//  Created by Evana Margain on 3/10/19.
//  Copyright © 2019 Evisoft. All rights reserved.
//

import Foundation
import CoreData

class Genre: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    @NSManaged var id: Int
    @NSManaged var name: String?
    
    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Genre> {
        return NSFetchRequest<Genre>(entityName: "Genre")
    }
    
    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Genre", in: managedObjectContext) else {
                fatalError("Failed to decode Genre")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey:CodingKeys.id)
        try container.encode(name, forKey:CodingKeys.name)
    }
}


