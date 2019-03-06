//
//  Constants.swift
//  MovieAppEvana
//
//  Created by Evana Margain on 3/5/19.
//  Copyright © 2019 Evisoft. All rights reserved.
//

import Foundation

final class MovieAppConstants {

    static let movieDBApiURL = "https://api.themoviedb.org/3/"
    static let apiKey = "api_key"
    static let apiKeyValue = "5aaf3853ee7a19ff80eca9937a5d619a"
    static let headerContentType = "Content-type"
    static let headerContentTypeValue = "application/json;charset=utf-8"
    static let parameterPage = "page"
    
    
    /* PopularList */
    static let popularURL = "discover/movie?sort_by=popularity.desc"
    static let popularTitle = "Popular"
    static let popularAlertTitle = "Alert"
    static let popularConfirmButton = "Ok"
    static let popularCellIdentifier = "popularCellIdentifier"
    static let movieNoTitle = "movie with no title"
    static let movieNoOverview = "movie with no overview"
    static let movieNoReleaseDate = "no release date"
    
    /* Configuration */
    static let configurationURL = "configuration"
    
    /* Generic */
    static let genericError = "Oops. There is an error. Please reload."
    static let cellUnexistentError = "Cell does not exist in storyboard"
    static let networkUnavailableError = "No network connection. Please connect to the internet"
    
}
