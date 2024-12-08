//
//  HTTPClient.swift
//  CombineImplementation
//
//  Created by Aditya on 08/12/24.
//

import Foundation
import Combine

enum NetworkError: Error {
    case badUrl
}

class HTTPClient {
    
    func fetchMovie(search: String, page: Int = 1) -> AnyPublisher<[Movies], Error> {
        guard let encodedSearch = search.urlEncoded,
              let url = URL(string: "https://www.omdbapi.com/?s=\(encodedSearch)&apikey=[Your API Key]&page=\(page)")
        else {
            return Fail(error: NetworkError.badUrl).eraseToAnyPublisher()
        }
              
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: MoviesData.self, decoder: JSONDecoder())
            .map(\.search)
            .receive(on: DispatchQueue.main)
            .catch { error -> AnyPublisher<[Movies], Error> in
                return Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
}

extension String {
    var urlEncoded: String? {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}
