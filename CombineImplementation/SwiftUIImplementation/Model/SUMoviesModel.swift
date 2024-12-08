//
//  SUMoviesModel.swift
//  CombineImplementation
//
//  Created by Aditya on 08/12/24.
//

import Foundation

struct SUMoviesData: Decodable {
    let search: [SUMovies]
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
}

struct SUMovies: Decodable, Identifiable {
    let title: String
    let year: String
    let imdbId: String
    let poster: URL?
    
    var id: String {
        imdbId
    }
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbId = "imdbID"
        case poster = "Poster"
    }
}
