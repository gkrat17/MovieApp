//
//  DetailsViewController.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/27/21.
//

import UIKit

final class DetailsViewController: UIViewController {
    var presenter: DetailsPresenter!

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var overviewTextLabel: UILabel!

    static func getInstance() -> DetailsViewController {
        .init(nibName: className, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension DetailsViewController: DetailsView {
    func show(error: String) {
        //
    }

    func updateDetails(from movie: Movie) {
        imageView.image = {
            if let image = movie.image {
                return UIImage(data: image)
            }
            return UIImage(named: "Movie")
        }()
        nameLabel.text = movie.name
        ratingLabel.text = "\(movie.averageRating)"
        overviewTextLabel.text = movie.overview
    }

    func insertItems(at indexPaths: [IndexPath]) {
        //
    }
}
