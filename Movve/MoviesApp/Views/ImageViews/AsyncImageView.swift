//
//  AsyncImageView.swift
//  MoviesApp
//
//  Created by Petar Glusac on 12.11.22..
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

class AsyncImageView: UIImageView {
    
    var task: URLSessionDataTask?
    
    func fetchPoster(posterPath: String) {
        image = nil
        if let task = task {
            task.cancel()
        }
        
        let urlString = "https://image.tmdb.org/t/p/w500\(posterPath)"
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            if let imageFromCache = imageCache.object(forKey: NSString(string:  url.absoluteString)) {
                self.image = imageFromCache
                return
            }
            task = session.dataTask(with: url) { data, response, error in
                if let data = data, let newImage = UIImage(data: data) {
                    imageCache.setObject(newImage, forKey: NSString(string: url.absoluteString))
                    DispatchQueue.main.async {
                        self.image = newImage
                    }
                }
            }
            task?.resume()
        }
    }
}
