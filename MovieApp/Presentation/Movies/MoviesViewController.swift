//
//  MoviesViewController.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/27/21.
//

import UIKit

final class MoviesViewController: UIViewController {
    var presenter: MoviesPresenter!

    static func getInstance() -> MoviesViewController {
        .init(nibName: "MoviesViewController", bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension MoviesViewController: MoviesView {}
