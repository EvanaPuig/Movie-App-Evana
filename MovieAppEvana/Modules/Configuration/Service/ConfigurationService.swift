//
//  ConfigurationService.swift
//  MovieAppEvana
//
//  Created by Evana Margain on 3/5/19.
//  Copyright © 2019 Evisoft. All rights reserved.
//

import Foundation
import Alamofire

class ConfigurationService: ConfigurationServiceProtocol {
    
    // Call protocol function
    
    func getConfiguration(success: @escaping(_ data: Configuration) -> (), failure: @escaping() -> ()) {
        
        let url = MovieAppConstants.popularURL
        
        APIManager.request(
            url,
            method: .get,
            parameters: [MovieAppConstants.apiKey: MovieAppConstants.apiKeyValue],
            encoding: URLEncoding.default,
            headers: [MovieAppConstants.headerContentType: MovieAppConstants.headerContentTypeValue],
            completion: { data in
                // mapping data
                do {
                    let decoded = try JSONDecoder().decode(Configuration.self, from: data)
                    success(decoded)
                } catch {
                    
                    failure()
                }
                
        }) { errorMsg, errorCode in
            failure()
        }
        
    }
    
}
