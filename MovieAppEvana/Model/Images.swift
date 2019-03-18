//
//  Images.swift
//  MovieAppEvana
//
//  Created by Evana Margain on 3/10/19.
//  Copyright © 2019 Evisoft. All rights reserved.
//

import Foundation
import CoreData

class Images: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case base_url
        case secure_base_url
        case backdrop_sizes
        case logo_sizes
        case poster_sizes
        case profile_sizes
        case still_sizes
    }
    
    @NSManaged var base_url: String?
    @NSManaged var secure_base_url: String?
    @NSManaged var backdrop_sizes: Array<String>?
    @NSManaged var logo_sizes: Array<String>?
    @NSManaged var poster_sizes: Array<String>?
    @NSManaged var profile_sizes: Array<String>?
    @NSManaged var still_sizes: Array<String>?
    
    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Images", in: managedObjectContext) else {
                fatalError("Failed to decode Images")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.base_url = try container.decodeIfPresent(String.self, forKey: .base_url)
        self.secure_base_url = try container.decodeIfPresent(String.self, forKey: .secure_base_url)
        self.backdrop_sizes = try container.decodeIfPresent([String].self, forKey: .backdrop_sizes)
        self.logo_sizes = try container.decodeIfPresent([String].self, forKey: .logo_sizes)
        self.poster_sizes = try container.decodeIfPresent([String].self, forKey: .poster_sizes)
        self.profile_sizes = try container.decodeIfPresent([String].self, forKey: .profile_sizes)
        self.still_sizes = try container.decodeIfPresent([String].self, forKey: .still_sizes)
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(base_url, forKey:CodingKeys.base_url)
        try container.encode(secure_base_url, forKey:CodingKeys.secure_base_url)
        try container.encode(backdrop_sizes, forKey:CodingKeys.backdrop_sizes)
        try container.encode(logo_sizes, forKey:CodingKeys.logo_sizes)
        try container.encode(poster_sizes, forKey:CodingKeys.poster_sizes)
        try container.encode(profile_sizes, forKey:CodingKeys.profile_sizes)
        try container.encode(still_sizes, forKey:CodingKeys.still_sizes)
    }
}
