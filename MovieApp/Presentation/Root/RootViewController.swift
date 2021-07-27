//
//  RootViewController.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/25/21.
//

import UIKit

final class RootViewController: UINavigationController {
    let moviesFactory: MoviesFactory = DefaultMoviesFactory()

    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = moviesFactory.make()
        setViewControllers([vc], animated: true)
    }
}
