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
    static let popularTitle = "Popular Movies"
    
    /* UpcomingList */
    static let upcomingURL = "discover/movie?primary_release_date.gte=2019-03-10"
    static let upcomingTitle = "Upcoming Movies"
    
    /* TopRatedList */
    static let topRatedURL = "discover/movie?sort_by=vote_average.desc"
    static let topRatedTitle = "Top Rated"
    
    /* Configuration */
    static let configurationURL = "configuration"
    
    /* Generic */
    static let genericError = "Oops. There is an error. Please reload."
    static let cellUnexistentError = "Cell does not exist in storyboard"
    static let networkUnavailableError = "No network connection. Please connect to the internet"
    static let genericAlertTitle = "Alert"
    static let genericConfirmButton = "Ok"
    static let genericCellIdentifier = "CategoriesCustomCell"
    static let movieNoTitle = "movie with no title"
    static let movieNoOverview = "movie with no overview"
    static let movieNoReleaseDate = "no release date"
}
