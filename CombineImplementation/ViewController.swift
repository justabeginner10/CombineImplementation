//
//  ViewController.swift
//  CombineImplementation
//
//  Created by Aditya on 08/12/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    private func moveToUIKitController() {
        let destination = MoviesViewController()
        self.navigationController?.pushViewController(destination, animated: true)
    }

    @IBAction private func didTapOnUIKitButton() {
        self.moveToUIKitController()
    }
}

