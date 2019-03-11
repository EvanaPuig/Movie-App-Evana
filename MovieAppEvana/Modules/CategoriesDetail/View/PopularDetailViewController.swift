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
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedMovie ?? Movie())
        
        if (imageUrl != nil) {
            imageView.sd_setImage(with: URL(string: imageUrl!)) { (image, error, type, url) in
                
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
