//
//  SUMoviesView.swift
//  CombineImplementation
//
//  Created by Aditya on 08/12/24.
//

import SwiftUI

struct SUMoviesView: View {
    @StateObject var viewModel: SUMoviesViewModel
    @State private var search: String = ""
    init(viewModel: SUMoviesViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            List(self.viewModel.movies) { movies in
                HStack {
                    Text("\(movies.title)")
                }
            }
            .searchable(text: $search)
            .onChange(of: search) {
                viewModel.sendSearchSubject(search: search)
            }
        }
    }
}

#Preview {
    NavigationStack {
        SUMoviesView(viewModel: SUMoviesViewModel(httpClient: SUHTTPClient()))
    }
}
