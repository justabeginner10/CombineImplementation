//
//  MoviesViewController.swift
//  CombineImplementation
//
//  Created by Aditya on 08/12/24.
//

import UIKit
import Combine

class MoviesViewController: UIViewController {

    lazy private var tableView: UITableView! = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy private var searchField: UISearchTextField! = {
        let searchField = UISearchTextField()
        searchField.delegate = self
        searchField.translatesAutoresizingMaskIntoConstraints = false
        return searchField
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not initialized")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.registerCell()
    }
    
    private func setupUI() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationItem.hidesBackButton = true
        
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.searchField)
        
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            searchField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            searchField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
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
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MoviesTableViewCell.identifier,
            for: indexPath
        ) as? MoviesTableViewCell else { return UITableViewCell() }
        cell.configureCell(with: "\(indexPath.row) row")
        return cell
    }
}

extension MoviesViewController: UITextFieldDelegate {
    
}
