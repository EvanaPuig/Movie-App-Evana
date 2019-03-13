//
//  UpcomingListViewController.swift
//  MovieAppEvana
//
//  Created by Evana Margain on 3/10/19.
//  Copyright © 2019 Evisoft. All rights reserved.
//

import UIKit

class UpcomingListViewController: UIViewController {
    // OUTLETS HERE
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // VARIABLES HERE
    lazy var viewModel: CategoriesListViewModel = {
        return CategoriesListViewModel()
    }()
    
    let searchController = UISearchController(searchResultsController: nil)
    private var filteredMovies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init the static view
        initView()
        
        // init view model
        initViewModel()
    }
    
    func initView() {
        self.navigationItem.title = MovieAppConstants.popularTitle
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(UINib(nibName: "CategoriesCustomCell", bundle: nil), forCellReuseIdentifier: "CategoriesCustomCell");
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Popular Movies"
        tableView.tableHeaderView = searchController.searchBar
        
        definesPresentationContext = true
    }
    
    func initViewModel() {
        // Naive binding
        viewModel.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert( message )
                }
            }
        }
        
        viewModel.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    self?.activityIndicator.isHidden = false
                    self?.activityIndicator.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.tableView.alpha = 0.0
                    })
                }else {
                    self?.activityIndicator.isHidden = true
                    self?.activityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.tableView.alpha = 1.0
                    })
                }
            }
        }
        
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.fetchConfiguration(caller: "upcoming")
        
    }
    
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: MovieAppConstants.genericAlertTitle, message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: MovieAppConstants.genericConfirmButton, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredMovies = viewModel.movies.filter({( movie : Movie) -> Bool in
            return movie.title?.lowercased().contains(searchText.lowercased()) ?? false
        })
        
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
}

extension UpcomingListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: CategoriesCustomCell = tableView.dequeueReusableCell(withIdentifier: MovieAppConstants.genericCellIdentifier, for: indexPath) as? CategoriesCustomCell else {
            fatalError(MovieAppConstants.cellUnexistentError)
        }
        
        if isFiltering() {
            cell.nameLabel.text = filteredMovies[indexPath.row].title
            cell.descriptionLabel.text = filteredMovies[indexPath.row].overview
            cell.mainImageView?.sd_setImage(with: URL( string: filteredMovies[indexPath.row].image_formatted_url ?? "" ), completed: nil)
            cell.dateLabel.text = filteredMovies[indexPath.row].release_date
        } else {
            let cellVM = viewModel.getCellViewModel( at: indexPath )
            cell.movieListCellViewModel = cellVM
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredMovies.count
        }
        
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let selectedMovie: Movie
        
        if isFiltering() {
            selectedMovie = filteredMovies[indexPath.row]
        } else {
            selectedMovie = self.viewModel.userPressed(at: indexPath)
        }
        
        let popularDetailViewController = PopularDetailViewController(nibName:"PopularDetailViewController", bundle: nil)
        popularDetailViewController.selectedMovie = selectedMovie
        popularDetailViewController.imageUrl = self.viewModel.selectedMovieUrl
        self.navigationController?.pushViewController(popularDetailViewController, animated: true)
        
        return indexPath
    }
    
}

extension UpcomingListViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}



