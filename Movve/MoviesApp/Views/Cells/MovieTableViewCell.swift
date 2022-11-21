//
//  MovieTableViewCell.swift
//  MoviesApp
//
//  Created by Petar Glusac on 12.11.22..
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieRealiseDateLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieImageView: AsyncImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
