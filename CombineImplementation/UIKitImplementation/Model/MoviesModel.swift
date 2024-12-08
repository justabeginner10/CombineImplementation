//
//  MoviesModel.swift
//  CombineImplementation
//
//  Created by Aditya on 08/12/24.
//

import Foundation

struct MoviesData: Decodable {
    let search: [Movies]
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
}

struct Movies: Decodable {
    let title: String
    let year: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
    }
}
