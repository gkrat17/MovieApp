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
        imageView.image = {
            if let image = model.image {
                return UIImage(data: image)
            }
            return UIImage(named: "Movie")
        }()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 16
        layer.borderWidth = 2
        layer.borderColor = UIColor.separator.cgColor
    }
}
