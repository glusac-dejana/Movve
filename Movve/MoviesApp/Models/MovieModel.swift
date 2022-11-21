//
//  MovieModel.swift
//  MoviesApp
//
//  Created by Petar Glusac on 12.11.22..
//

import Foundation

struct SearchResult: Codable {
    let id: Int?
    var original_title: String?
    var release_date: String?
    var poster_path: String?
    var overview: String?
    var genre_ids: [Int]?
}

struct SearchResults: Codable {
    let results: [SearchResult]
}
