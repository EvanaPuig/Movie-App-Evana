//  
//  PopularViewModel.swift
//  MovieAppEvana
//
//  Created by Evana Margain on 3/1/19.
//  Copyright © 2019 Evisoft. All rights reserved.
//

import Foundation

class PopularListViewModel {
    private let service: PopularListServiceProtocol
    
    private var movies: [Movie] = [Movie]()
    private var configuration = Configuration()
    
    var isAllowSegue: Bool = true
    
    //Define selected model
    var selectedMovie: Movie?

    private var cellViewModels: [PopularListCellViewModel] = [PopularListCellViewModel]() {
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

    init(withPopular serviceProtocol: PopularListServiceProtocol = PopularListService() ) {
        self.service = serviceProtocol

        NotificationCenter.default.addObserver(self, selector: #selector(self.networkStatusChanged(_:)), name: NSNotification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
        Reach().monitorReachabilityChanges()

    }

    //MARK: Internet monitor status
    @objc func networkStatusChanged(_ notification: Notification) {
        self.networkStatus = Reach().connectionStatus()
    }
    
    //MARK: -- Example Func
    func fetchConfiguration() {
        switch networkStatus {
        case .offline:
            self.isDisconnected = true
            self.internetConnectionStatus?()
        case .online:
            self.isLoading = true
            self.service.getConfiguration(success: { data in
                print("CONFIGURATION: --- \(data)")
                self.configuration = data
                self.fetchMovies(pageNumber: 1)
                self.isLoading = false
            }) {
                print("error")
                self.isLoading = false
            }
        default:
            break
        }
    }

    //MARK: -- Example Func
    func fetchMovies(pageNumber: Int) {
        switch networkStatus {
        case .offline:
            self.isDisconnected = true
            self.internetConnectionStatus?()
        case .online:
            self.isLoading = true
            
            self.service.getPopularMovies(pageNumber: pageNumber, success: { data in
                print("MOVIES: --- \(data)")
                self.movies = data.results
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
    
    func getCellViewModel( at indexPath: IndexPath ) -> PopularListCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCellViewModel( movie: Movie ) -> PopularListCellViewModel {
        
        let baseUrl = configuration.images?.secure_base_url
        let imageSize = configuration.images?.poster_sizes?[4]
        let posterPath = movie.poster_path
        
        let formattedURL = (baseUrl ?? "") + (imageSize ?? "") + (posterPath ?? "")
        
        return PopularListCellViewModel( titleText: movie.title ?? MovieAppConstants.movieNoTitle,
                                         descText: movie.overview ?? MovieAppConstants.movieNoOverview,
                                         imageUrl: formattedURL,
                                         dateText: movie.release_date ?? MovieAppConstants.movieNoReleaseDate )
    }
    
    private func processFetchedMovie( movies: [Movie] ) {
        self.movies = movies // Cache
        var vms = [PopularListCellViewModel]()
        for movie in movies {
            vms.append( createCellViewModel(movie: movie) )
        }
        self.cellViewModels = vms
    }

}

extension PopularListViewModel {
    func userPressed( at indexPath: IndexPath ){
        let movie = self.movies[indexPath.row]
            self.isAllowSegue = true
            self.selectedMovie = movie
    }
}

struct PopularListCellViewModel {
    let titleText: String
    let descText: String
    let imageUrl: String
    let dateText: String
}
