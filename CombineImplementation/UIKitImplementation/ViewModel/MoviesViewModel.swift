//
//  MoviesViewModel.swift
//  CombineImplementation
//
//  Created by Aditya on 08/12/24.
//

import Foundation
import Combine

class MoviesViewModel {
    @Published private(set) var movies: [Movies] = []
    private var cancellables: Set<AnyCancellable> = []
    @Published var loadingComplete: Bool = false
    
    private var searchSubject = CurrentValueSubject<String, Never>("")
    
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
        self.setupSearchSubject()
    }
    
    private func setupSearchSubject() {
        searchSubject
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { [weak self] searchText in
                self?.loadMovies(search: searchText)
            }
            .store(in: &cancellables)
    }
    
    func sendSearchEvent(with searchText: String) {
        searchSubject.send(searchText)
    }
    
    private func loadMovies(search: String) {
        httpClient.fetchMovie(search: search)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.loadingComplete = true
                case .failure(let error):
                    self?.loadingComplete = false
                    debugPrint(error)
                }
            } receiveValue: { [weak self] movies in
                self?.movies = movies
            }
            .store(in: &cancellables)
    }
}
