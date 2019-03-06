//
//  SearchResult.swift
//  MovieAppEvana
//
//  Created by Evana Margain on 3/6/19.
//  Copyright © 2019 Evisoft. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    var page: Int
    var results: [Movie]
    var total_results: Int
    var total_pages: Int 
}
