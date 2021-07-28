//
//  MovieSummaryView.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/27/21.
//

import UIKit

final class MovieSummaryView: DefaultView {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!

    func configure(from movie: MovieSummaryViewModel) {
        nameLabel.text = movie.name
        ratingLabel.text = movie.rating
        if let image = movie.image {
            imageView.image = UIImage(data: image)
        }
    }
}
