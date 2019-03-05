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

    func getPopularMovies(success: @escaping(_ data: Movie) -> (), failure: @escaping() -> ()) {

        let url = "movie/550"
            
        APIManager.request(
            url,
            method: .get,
            parameters: ["api_key":"5aaf3853ee7a19ff80eca9937a5d619a"],
            encoding: URLEncoding.default,
            headers: ["Content-type":"application/json;charset=utf-8"],
            completion: { data in
                // mapping data
                do {
                    let decoded = try JSONDecoder().decode(Movie.self, from: data)
                    success(decoded)
                } catch {
                    
                    failure()
                }
                
        }) { errorMsg, errorCode in
            failure()
        }

    }

}
