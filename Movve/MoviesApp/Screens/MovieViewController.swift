//
//  MovieViewController.swift
//  MoviesApp
//
//  Created by Petar Glusac on 18.11.22..
//

import UIKit

class MovieViewController: UIViewController {
    
    func movieGotSelected(movie: SearchResult) {
        DispatchQueue.main.async {
            self.movieTitleLabel.text = movie.original_title
            if let posterPath = movie.poster_path {
                self.posterIV.fetchPoster(posterPath: posterPath)
            }
            self.descriptionLabel.text = movie.overview
        }
    }
    

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingIV: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var posterIV: AsyncImageView!
    @IBOutlet weak var backgraundPosterIV: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
