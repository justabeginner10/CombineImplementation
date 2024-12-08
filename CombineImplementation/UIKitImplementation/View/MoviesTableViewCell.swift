//
//  MoviesTableViewCell.swift
//  CombineImplementation
//
//  Created by Aditya on 08/12/24.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    static let identifier = "MoviesTableViewCell"
    
    lazy var labelText: UILabel! = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(self.labelText)
        
        NSLayoutConstraint.activate([
            labelText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            labelText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            labelText.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configureCell(with text: String) {
        labelText.text = text
    }
}
