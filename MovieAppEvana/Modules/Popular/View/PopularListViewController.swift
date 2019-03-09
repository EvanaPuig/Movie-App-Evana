//  
//  PopularListViewController.swift
//  MovieAppEvana
//
//  Created by Evana Margain on 3/1/19.
//  Copyright © 2019 Evisoft. All rights reserved.
//

import UIKit

class PopularListViewController: UIViewController {
    // OUTLETS HERE
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // VARIABLES HERE
    lazy var viewModel: PopularListViewModel = {
        return PopularListViewModel()
    }()

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
        
        tableView.register(UINib(nibName: "PopularListCell", bundle: nil), forCellReuseIdentifier: "PopularListCell");
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
        
        viewModel.fetchConfiguration()
        
    }
    
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: MovieAppConstants.popularAlertTitle, message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: MovieAppConstants.popularConfirmButton, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension PopularListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: PopularListCell = tableView.dequeueReusableCell(withIdentifier: MovieAppConstants.popularCellIdentifier, for: indexPath) as? PopularListCell else {
            fatalError(MovieAppConstants.cellUnexistentError)
        }
        
        let cellVM = viewModel.getCellViewModel( at: indexPath )
        cell.movieListCellViewModel = cellVM
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let selectedMovie = self.viewModel.userPressed(at: indexPath)
        print(selectedMovie)
        
        let popularDetailViewController = PopularDetailViewController(nibName:"PopularDetailViewController", bundle: nil)
        popularDetailViewController.selectedMovie = selectedMovie
        popularDetailViewController.imageUrl = self.viewModel.selectedMovieUrl
        self.navigationController?.pushViewController(popularDetailViewController, animated: true)
        
        return indexPath
    }
    
}


