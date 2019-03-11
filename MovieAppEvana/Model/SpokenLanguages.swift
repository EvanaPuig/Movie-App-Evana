//
//  SpokenLanguages.swift
//  MovieAppEvana
//
//  Created by Evana Margain on 3/10/19.
//  Copyright © 2019 Evisoft. All rights reserved.
//

import Foundation
import CoreData

class SpokenLanguages: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case iso_639_1
        case name
    }
    
    @NSManaged var iso_639_1: String?
    @NSManaged var name: String?
    
    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Spoken Languages", in: managedObjectContext) else {
                fatalError("Failed to decode Spoken Languages")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.iso_639_1 = try container.decodeIfPresent(String.self, forKey: .iso_639_1)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(iso_639_1, forKey:CodingKeys.iso_639_1)
        try container.encode(name, forKey:CodingKeys.name)
    }
}
