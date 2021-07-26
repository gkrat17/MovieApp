//
//  RootViewController.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/25/21.
//

import UIKit

class RootViewController: UINavigationController {
    let popular = DefaultPopularMoviesRepository()
    let similar = DefaultSimilarMoviesRepository()
    let image = DefaultMovieImageRepository()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        popular.movies(params: .init(page: 1)) { result in
            print("Popular:", result)
        }

        similar.movies(params: .init(movieId: 84958, page: 1)) { result in
            print("Similar:", result)
        }

        image.image(id: "/bZGAX8oMDm3Mo5i0ZPKh9G2OcaO.jpg") { result in
            print("Image:", result)
        }
    }


}

