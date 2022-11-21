//
//  FavoritesViewController.swift
//  MoviesApp
//
//  Created by Petar Glusac on 13.11.22..
//

import UIKit

class FavoritesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var favoritesCollectionView: UICollectionView!
    
    var movies: [SearchResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesCollectionView.dataSource = self
        favoritesCollectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let encodedMovies = UserDefaults.standard.data(forKey: "favoriteMovies") {
            do {
                movies = try JSONDecoder().decode([SearchResult].self, from: encodedMovies)
                
                DispatchQueue.main.async {
                    self.favoritesCollectionView.reloadData()
                }
            }
            catch {
                print(error)
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = favoritesCollectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCell", for: indexPath) as! FavoriteCollectionViewCell
        
        if let posterPath = movies[indexPath.row].poster_path {
            cell.favoriteImageView.fetchPoster(posterPath: posterPath)
        }
        return cell
    }
}
