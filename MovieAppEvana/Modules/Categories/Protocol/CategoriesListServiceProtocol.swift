//  
//  PopularServiceProtocol.swift
//  MovieAppEvana
//
//  Created by Evana Margain on 3/1/19.
//  Copyright © 2019 Evisoft. All rights reserved.
//

import Foundation

protocol CategoriesListServiceProtocol {

    /// - Parameters:
    ///   - success: -- success closure response, add your Model on this closure.
    ///                 example: success(_ data: YourModelName) -> ()
    ///   - failure: -- failure closure response, add your Model on this closure.  
    ///                 example: success(_ data: APIError) -> ()
    func getPopularMovies(pageNumber: Int, success: @escaping(_ data: SearchResult) -> (), failure: @escaping() -> ())
    func getUpcomingMovies(pageNumber: Int, success: @escaping(_ data: SearchResult) -> (), failure: @escaping() -> ())
    func getTopRatedMovies(pageNumber: Int, success: @escaping(_ data: SearchResult) -> (), failure: @escaping() -> ())
    func getConfiguration(success: @escaping(_ data: Configuration) -> (), failure: @escaping() -> ())

}
