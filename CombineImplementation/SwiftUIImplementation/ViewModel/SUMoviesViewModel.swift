//
//  SUMoviesViewModel.swift
//  CombineImplementation
//
//  Created by Aditya on 08/12/24.
//

import Foundation
import SwiftUI
import Combine

class SUMoviesViewModel: ObservableObject {
    @Published var movies: [SUMovies] = []
    @Published var loadingComplete: Bool = false
    private var searchSubject = CurrentValueSubject<String, Never>("")
    
    private var cancellable: Set<AnyCancellable> = []
    private let httpClient: SUHTTPClient
    
    init(httpClient: SUHTTPClient) {
        self.httpClient = httpClient
        
        self.setupSearchSubject()
    }
    
    private func setupSearchSubject() {
        searchSubject
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { [weak self] searchText in
                self?.loadMovies(search: searchText)
            }
            .store(in: &cancellable)
    }
    
    func sendSearchSubject(search: String) {
        searchSubject.send(search)
    }
    
    private func loadMovies(search: String) {
        httpClient.fetchMovie(search: search)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.loadingComplete = true
                case .failure(let error):
                    debugPrint("\(error.localizedDescription)")
                }
            } receiveValue: { [weak self] movies in
                self?.movies = movies
            }
            .store(in: &cancellable)
    }
    
}
