//
//  NetworkManager.swift
//  MoviesApp
//
//  Created by Petar Glusac on 12.11.22..
//

import Foundation

class NetworkManager {
    
    var delegate: MovieDelegate?
    let apiKey = "b00dc2e39fd4cc23884c5735882d65a8"
    let urlBase = "https://api.themoviedb.org/3/"
    
    func fetchMovie(movieName: String) {
        let newMovieName = movieName.replacingOccurrences(of: " ", with: "%20")
        let urlString = "\(urlBase)search/movie?api_key=\(apiKey)&query=\(newMovieName)"
        let url = URL(string: urlString)
        let session = URLSession.shared
        if let url = url {
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                }
                if let data = data {
                    do {
                        let decodedData = try JSONDecoder().decode(SearchResults.self, from: data)
                        self.delegate?.didReciveMovie(movie: decodedData.results)
                    } catch(let error) {
                        self.delegate?.didFailWithError(error: error)
                    }
                }
            }
            task.resume()
        }
    }
}

protocol MovieDelegate {
    func didFailWithError(error: Error)
    func didReciveMovie(movie: [SearchResult])
}
