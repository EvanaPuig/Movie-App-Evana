//  
//  PopularService.swift
//  MovieAppEvana
//
//  Created by Evana Margain on 3/1/19.
//  Copyright © 2019 Evisoft. All rights reserved.
//

import Foundation
import Alamofire

class PopularListService: PopularListServiceProtocol {
    
    // Call protocol function

    func getPopularMovies(pageNumber: Int, success: @escaping(_ data: SearchResult) -> (), failure: @escaping() -> ()) {

        let url = MovieAppConstants.popularURL
            
        APIManager.request(
            url,
            method: .get,
            parameters: [MovieAppConstants.apiKey : MovieAppConstants.apiKeyValue, MovieAppConstants.parameterPage: pageNumber],
            encoding: URLEncoding.default,
            headers: [MovieAppConstants.headerContentType : MovieAppConstants.headerContentType],
            completion: { data in
                // mapping data
                do {
                    let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                    success(searchResult)
                } catch {
                    
                    failure()
                }
                
        }) { errorMsg, errorCode in
            failure()
        }

    }
    
    func getConfiguration(success: @escaping(_ data: Configuration) -> (), failure: @escaping() -> ()) {
        
        let url = MovieAppConstants.configurationURL
        
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
