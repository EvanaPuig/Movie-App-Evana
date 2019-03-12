//  
//  PopularViewModel.swift
//  MovieAppEvana
//
//  Created by Evana Margain on 3/1/19.
//  Copyright © 2019 Evisoft. All rights reserved.
//

import Foundation
import CoreData

class CategoriesListViewModel {
    private let service: CategoriesListServiceProtocol
    
    private var movies: [Movie] = [Movie]()
    var formattedUrls = [String]()
    var configuration: Configuration?
    
    //Define selected model
    var selectedMovie: Movie?
    var selectedMovieUrl: String?

    private var cellViewModels: [CategoriesCustomCellViewModel] = [CategoriesCustomCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }

    /// Count your data in model
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    //MARK: -- Network checking

    /// Define networkStatus for check network connection
    var networkStatus = Reach().connectionStatus()

    /// Define boolean for internet status, call when network disconnected
    var isDisconnected: Bool = false {
        didSet {
            self.alertMessage = MovieAppConstants.networkUnavailableError
            self.internetConnectionStatus?()
        }
    }

    //MARK: -- UI Status

    /// Update the loading status, use HUD or Activity Indicator UI
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }

    /// Showing alert message, use UIAlertController or other Library
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }

    //MARK: -- Closure Collection
    var reloadTableViewClosure: (()->())?
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var internetConnectionStatus: (() -> ())?
    var serverErrorStatus: (() -> ())?
    var didGetData: (() -> ())?

    init(withPopular serviceProtocol: CategoriesListServiceProtocol = CategoriesListService()) {
        self.service = serviceProtocol

        NotificationCenter.default.addObserver(self, selector: #selector(self.networkStatusChanged(_:)), name: NSNotification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
        Reach().monitorReachabilityChanges()
        
    }

    //MARK: Internet monitor status
    @objc func networkStatusChanged(_ notification: Notification) {
        self.networkStatus = Reach().connectionStatus()
    }
    
    func fetchConfiguration(caller: String) {
        switch networkStatus {
        case .offline:
            self.isDisconnected = true
            self.internetConnectionStatus?()
        case .online:
            self.isLoading = true
            self.service.getConfiguration(success: { data in
                //print("CONFIGURATION: --- \(data)")
                self.configuration = self.service.loadPersistedConfiguration()?.first
                
                if(caller == "popular"){
                    self.fetchPopularMovies(pageNumber: 1)
                } else if(caller == "topRated") {
                    self.fetchTopRatedMovies(pageNumber: 1)
                }else {
                    self.fetchUpcomingMovies(pageNumber: 1)
                }
                self.isLoading = false
            }) {
                print("error")
                self.isLoading = false
            }
        default:
            break
        }
    }

    func fetchPopularMovies(pageNumber: Int) {
        switch networkStatus {
        case .offline:
            self.isDisconnected = true
            self.internetConnectionStatus?()
        case .online:
            self.isLoading = true
            
            self.service.getPopularMovies(pageNumber: pageNumber, success: { data in
                //print("POPULAR MOVIES: --- \(data)")
                
                let searchResults = self.service.loadSavedData()
                self.movies = Array((searchResults?[0].results)!)
                print("Movies: \(self.movies)")
                self.processFetchedMovie(movies: self.movies)
                self.isLoading = false
            }) {
                print("error")
                self.isLoading = false
            }
        default:
            break
        }
    }
    
    func fetchTopRatedMovies(pageNumber: Int) {
        switch networkStatus {
        case .offline:
            self.isDisconnected = true
            self.internetConnectionStatus?()
        case .online:
            self.isLoading = true
            
            self.service.getTopRatedMovies(pageNumber: pageNumber, success: { data in
                //print("TOP RATED MOVIES: --- \(data)")
                //self.movies = data.results
                //self.movies = self.service.loadSavedData()
                self.processFetchedMovie(movies: self.movies)
                self.isLoading = false
            }) {
                print("error")
                self.isLoading = false
            }
        default:
            break
        }
    }
    
    func fetchUpcomingMovies(pageNumber: Int) {
        switch networkStatus {
        case .offline:
            self.isDisconnected = true
            self.internetConnectionStatus?()
        case .online:
            self.isLoading = true
            
            self.service.getUpcomingMovies(pageNumber: pageNumber, success: { data in
                //print("UPCOMING MOVIES: --- \(data)")
                //self.movies = data.results
                //self.movies = self.service.loadSavedData()
                self.processFetchedMovie(movies: self.movies)
                self.isLoading = false
            }) {
                print("error")
                self.isLoading = false
            }
        default:
            break
        }
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> CategoriesCustomCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCellViewModel( movie: Movie ) -> CategoriesCustomCellViewModel {
        
        let baseUrl = configuration?.images.secure_base_url
        let imageSize = configuration?.images.poster_sizes?[4]
        let posterPath = movie.poster_path
        
        let formattedURL = (baseUrl ?? "") + (imageSize ?? "") + (posterPath ?? "")
        formattedUrls.append(formattedURL)
        
        return CategoriesCustomCellViewModel( titleText: movie.title ?? MovieAppConstants.movieNoTitle,
                                         descText: movie.overview ?? MovieAppConstants.movieNoOverview,
                                         imageUrl: formattedURL,
                                         dateText: movie.release_date ?? MovieAppConstants.movieNoReleaseDate )
    }
    
    private func processFetchedMovie( movies: [Movie] ) {
        self.movies = movies // Cache
        var vms = [CategoriesCustomCellViewModel]()
        for movie in movies {
            vms.append( createCellViewModel(movie: movie) )
        }
        self.cellViewModels = vms
    }
    
    

}

extension CategoriesListViewModel {
    func userPressed( at indexPath: IndexPath ) -> Movie{
        let movie = self.movies[indexPath.row]
        let imageUrl = self.formattedUrls[indexPath.row]
        self.selectedMovie = movie
        self.selectedMovieUrl = imageUrl
        return movie
    }
}
