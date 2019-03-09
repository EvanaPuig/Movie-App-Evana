//
//  PopularListCell.swift
//  MovieAppEvana
//
//  Created by Evana Margain on 3/8/19.
//  Copyright © 2019 Evisoft. All rights reserved.
//

import UIKit

class PopularListCell: UITableViewCell {
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    var movieListCellViewModel : PopularListCellViewModel? {
        didSet {
            nameLabel.text = movieListCellViewModel?.titleText
            descriptionLabel.text = movieListCellViewModel?.descText
            mainImageView?.sd_setImage(with: URL( string: movieListCellViewModel?.imageUrl ?? "" ), completed: nil)
            dateLabel.text = movieListCellViewModel?.dateText
        }
    }
}

