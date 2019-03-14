//
//  CategoriesCustomCell.swift
//  MovieAppEvana
//
//  Created by Evana Margain on 3/8/19.
//  Copyright © 2019 Evisoft. All rights reserved.
//

import UIKit

class CategoriesCustomCell: UITableViewCell {
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    var movieListCellViewModel : CategoriesCustomCellViewModel? {
        didSet {
            nameLabel.text = movieListCellViewModel?.titleText
            popularityLabel.text = "Popularity: \(movieListCellViewModel?.popularityText ?? "0.0")"
            mainImageView?.sd_setImage(with: URL( string: movieListCellViewModel?.imageUrl ?? "" ), completed: nil)
            dateLabel.text = "Release date: \(movieListCellViewModel?.dateText ?? "")"
        }
    }
}

