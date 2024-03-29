//
//  SearchResult.swift
//  MovieAppEvana
//
//  Created by Evana Margain on 3/6/19.
//  Copyright © 2019 Evisoft. All rights reserved.
//

import Foundation
import CoreData

class SearchResult: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case unique_id
        case page
        case results
        case total_results
        case total_pages
    }
    
    @nonobjc public class func createFetchRequest() -> NSFetchRequest<SearchResult> {
        return NSFetchRequest<SearchResult>(entityName: "SearchResult")
    }
    
    @NSManaged var unique_id: Int16
    @NSManaged var page: Int16
    @NSManaged var results: Set<Movie>
    @NSManaged var total_results: Int32
    @NSManaged var total_pages: Int32
    
    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "SearchResult", in: managedObjectContext) else {
                fatalError("Failed to decode Search Result")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.unique_id = Int16(try container.decodeIfPresent(Int.self, forKey: .unique_id) ?? 0)
        self.page = Int16(try container.decodeIfPresent(Int.self, forKey: .page) ?? 0)
        self.results = try container.decodeIfPresent(Set<Movie>.self, forKey: .results) ?? Set()
        self.total_results = Int32(try container.decodeIfPresent(Int.self, forKey: .total_results) ?? 0)
        self.total_pages = Int32(try container.decodeIfPresent(Int.self, forKey: .total_pages) ?? 0)
    }
    
    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(unique_id, forKey:CodingKeys.unique_id)
        try container.encode(page, forKey:CodingKeys.page)
        try container.encode(results, forKey:CodingKeys.results)
        try container.encode(total_results, forKey:CodingKeys.total_results)
        try container.encode(total_pages, forKey:CodingKeys.total_pages)
    }
}
