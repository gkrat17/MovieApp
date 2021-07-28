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

    func configure(from model: MovieSummaryViewModel) {
        nameLabel.text = model.name
        ratingLabel.text = model.rating
        if let image = model.image {
            imageView.image = UIImage(data: image)
        } else {
            // set default image
        }
    }
}
