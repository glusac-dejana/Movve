//
//  SearchViewController.swift
//  MoviesApp
//
//  Created by Petar Glusac on 11.11.22..
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    

    @IBOutlet weak var movieTableView: UITableView!
    var movies: [SearchResult] = []
    let searchController = UISearchController()
    let movieManager = MovieManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        movieManager.delegate = self
        movieTableView.delegate = self
        movieTableView.dataSource = self
        searchController.searchBar.delegate = self
        self.movieTableView.rowHeight = 100
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = UIColor.white
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let movieName = searchBar.text {
            movieManager.fetchMovie(movieName: movieName)
        }
    }
}

extension SearchViewController: MovieDelegate, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieTableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableViewCell
        cell.movieTitleLabel.text = movies[indexPath.row].title
        
        if let posterPath = movies[indexPath.row].posterPath {
            cell.movieImageView.fetchPoster(posterPath: posterPath)
        }
        
        if let isoDate = movies[indexPath.row].releaseDate {

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from:isoDate)!
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: date)
            if let finalDate = calendar.date(from:components) {
                let format = finalDate.getFormattedDate(format: "dd/MM/yyyy") // Set output format
                cell.movieRealiseDateLabel.text = "\(format)"
            }
        }
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didReciveMovie(movie: [SearchResult]) {
        DispatchQueue.main.async {
            self.movies = movie
            self.movieTableView.reloadData()
        }
    }
}

extension Date {
    func getFormattedDate(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
