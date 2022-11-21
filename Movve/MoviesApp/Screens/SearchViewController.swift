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
    let movieManager = NetworkManager()
    
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
        cell.movieTitleLabel.text = movies[indexPath.row].original_title
        
        if let posterPath = movies[indexPath.row].poster_path {
            cell.movieImageView.fetchPoster(posterPath: posterPath)
        }
        
        if let isoDate = movies[indexPath.row].release_date {
            
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  showAlert(movie: movies[indexPath.row])
      //  movieInFavoritesAlert(movie: movies[indexPath.row])


        let movieVC = self.storyboard?.instantiateViewController(withIdentifier: "movieVC") as! MovieViewController
        movieVC.movieGotSelected(movie: movies[indexPath.row])
        self.present(movieVC, animated: true, completion: nil)
    
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




//MARK: - alerts

//    func showAlert(movie: SearchResult) {
//        let alert = UIAlertController(title: "Add movie to Favorite", message: "Do you want to add \(movie.original_title!) to Favorie?", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "cancel", style: .cancel))
//        alert.addAction(UIAlertAction(title: "add", style: .default, handler: { action in
//            do {
//                if let moviesData = UserDefaults.standard.data(forKey: "favoriteMovies") {
//                    var decodedMovies = try JSONDecoder().decode([SearchResult].self, from: moviesData)
//
//                    if !decodedMovies.contains(where: { $0.id == movie.id}) {
//                        decodedMovies.append(movie)
//                        let encodedMovies = try JSONEncoder().encode(decodedMovies)
//                        UserDefaults.standard.set(encodedMovies, forKey: "favoriteMovies")
//                    }
//                }
//                else {
//                    let encodedMovies = try JSONEncoder().encode([movie])
//                    UserDefaults.standard.set(encodedMovies, forKey: "favoriteMovies")
//                }
//
//            }
//            catch {
//                print(error)
//            }
//
//        }))
//        present(alert, animated: true)
//    }
//
    
//    func movieInFavoritesAlert(movie: SearchResult) {
//        do {
//            if let moviesData = UserDefaults.standard.data(forKey: "favoriteMovies") {
//                var decodedMovies = try JSONDecoder().decode([SearchResult].self, from: moviesData)
//                if decodedMovies.contains(where: { $0.id == movie.id}) {
//                    let alertAddedMovie = UIAlertController(title: "Can't add \(movie.original_title!) to Favorites", message: "Movie is already added to Favorires!", preferredStyle: .alert)
//                    alertAddedMovie.addAction(UIAlertAction(title: "OK", style: .default))
//                    self.present(alertAddedMovie, animated: true)
//                }}}
//        catch {
//        }
//    }
    
