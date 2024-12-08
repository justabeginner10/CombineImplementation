//
//  MoviesViewController.swift
//  CombineImplementation
//
//  Created by Aditya on 08/12/24.
//

import UIKit
import Combine

class MoviesViewController: UIViewController {

    private var viewModel: MoviesViewModel
    
    private var cancellable: Set<AnyCancellable> = []
    
    lazy private var tableView: UITableView! = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy private var searchField: UISearchBar! = {
        let searchField = UISearchBar()
        searchField.placeholder = "Search Movies"
        searchField.delegate = self
        searchField.translatesAutoresizingMaskIntoConstraints = false
        return searchField
    }()
    
    init(viewModel: MoviesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not initialized")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.registerCell()
        
        viewModel.$loadingComplete
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completed in
                if completed {
                    self?.tableView.reloadData()
                }
            }.store(in: &cancellable)
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationItem.hidesBackButton = true
        
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.searchField)
        
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            searchField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            searchField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            searchField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.searchField.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    private func registerCell() {
        tableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: MoviesTableViewCell.identifier)
    }
}

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MoviesTableViewCell.identifier,
            for: indexPath
        ) as? MoviesTableViewCell else { return UITableViewCell() }
        cell.configureCell(with: viewModel.movies[indexPath.row].title)
        return cell
    }
}

extension MoviesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.sendSearchEvent(with: searchText)
    }
}
