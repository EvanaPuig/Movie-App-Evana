//
//  ConfigurationProtocol.swift
//  MovieAppEvana
//
//  Created by Evana Margain on 3/5/19.
//  Copyright © 2019 Evisoft. All rights reserved.
//

import Foundation

protocol ConfigurationServiceProtocol {
    
    /// - Parameters:
    ///   - success: -- success closure response, add your Model on this closure.
    ///                 example: success(_ data: YourModelName) -> ()
    ///   - failure: -- failure closure response, add your Model on this closure.
    ///                 example: success(_ data: APIError) -> ()
    func getConfiguration(success: @escaping(_ data: Configuration) -> (), failure: @escaping() -> ())
    
}
