//
//  SUMoviesViewController.swift
//  CombineImplementation
//
//  Created by Aditya on 08/12/24.
//

import UIKit
import SwiftUI
import Combine

class SUMoviesViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupSwiftUIView()
    }
    
    private func setupSwiftUIView() {
        let swiftUIView = SUMoviesView(viewModel: SUMoviesViewModel(httpClient: SUHTTPClient()))
        
        let hostingController = UIHostingController(rootView: swiftUIView)
        addChild(hostingController)
        
        view.addSubview(hostingController.view)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        hostingController.didMove(toParent: self)
    }
}
