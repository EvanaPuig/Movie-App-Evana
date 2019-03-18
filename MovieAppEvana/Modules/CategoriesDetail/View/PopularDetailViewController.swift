//
//  PopularDetailViewController.swift
//  MovieAppEvana
//
//  Created by Evana Margain on 3/5/19.
//  Copyright © 2019 Evisoft. All rights reserved.
//

import UIKit
import SDWebImage

class PopularDetailViewController: UIViewController {

    var selectedMovie: Movie?
    var imageUrl: String?
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var overviewText: UITextView!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedMovie ?? Movie())
        
        movieTitle.text = selectedMovie?.title
        overviewText.text = selectedMovie?.overview
        popularityLabel.text = selectedMovie?.popularity.description ?? "0" + "/10"
        genreLabel.text = "Genre: " + (selectedMovie?.genres?.first?.name ?? "None")
        releaseDateLabel.text = "Release Date: " + (selectedMovie?.release_date)!
        runtimeLabel.text = "Duration: " + (selectedMovie?.runtime.description)! + "minutes"
        
        if (imageUrl != nil) {
            imageView.sd_setImage(with: URL(string: imageUrl!)) { (image, error, type, url) in
                
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
