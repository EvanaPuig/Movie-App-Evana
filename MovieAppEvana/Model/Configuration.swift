//
//  Configuration.swift
//  MovieAppEvana
//
//  Created by Evana Margain on 3/5/19.
//  Copyright © 2019 Evisoft. All rights reserved.
//

import Foundation
import CoreData

class Configuration: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case unique_id
        case images
        case change_keys
    }
    
    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Configuration> {
        return NSFetchRequest<Configuration>(entityName: "Configuration")
    }
    
    @NSManaged var unique_id: Int16
    @NSManaged var images: Images
    @NSManaged var change_keys: Array<String>?
    
    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Configuration", in: managedObjectContext) else {
                    fatalError("Failed to decode Configuration")
                }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.unique_id = Int16(try container.decodeIfPresent(Int.self, forKey: .unique_id) ?? 0)
        self.images = try container.decodeIfPresent(Images.self, forKey: .images) ?? Images()
        self.change_keys = try container.decodeIfPresent([String].self, forKey: .change_keys)
        
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(unique_id, forKey: CodingKeys.unique_id)
        try container.encode(images, forKey:CodingKeys.images)
        try container.encode(change_keys, forKey:CodingKeys.change_keys)
    }
}


