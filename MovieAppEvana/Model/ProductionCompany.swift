//
//  ProductionCompanies.swift
//  MovieAppEvana
//
//  Created by Evana Margain on 3/10/19.
//  Copyright © 2019 Evisoft. All rights reserved.
//

import Foundation
import CoreData

class ProductionCompany: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case logo_path
        case origin_country
    }
    
    @NSManaged var name: String?
    @NSManaged var id: Int
    @NSManaged var logo_path: String?
    @NSManaged var origin_country: String?
    
    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Production Company", in: managedObjectContext) else {
                fatalError("Failed to decode Production Company")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        self.logo_path = try container.decodeIfPresent(String.self, forKey: .logo_path)
        self.origin_country = try container.decodeIfPresent(String.self, forKey: .origin_country)
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey:CodingKeys.name)
        try container.encode(id, forKey:CodingKeys.id)
        try container.encode(logo_path, forKey:CodingKeys.logo_path)
        try container.encode(origin_country, forKey:CodingKeys.origin_country)
    }
}

