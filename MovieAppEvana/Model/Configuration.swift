//
//  Configuration.swift
//  MovieAppEvana
//
//  Created by Evana Margain on 3/5/19.
//  Copyright © 2019 Evisoft. All rights reserved.
//

import Foundation

struct Configuration: Codable {
    var images: Images?
    var change_keys: Array<String>
}

struct Images: Codable {
    var base_url: String?
    var secure_base_url: String?
    var backdrop_sizes: Array<String>?
    var logo_sizes: Array<String>?
    var poster_sizes: Array<String>?
    var profile_sizes: Array<String>?
    var still_sizes: Array<String>?
}
