//
//  MovieSummaryView.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/27/21.
//

import UIKit

final class MovieSummaryView: DefaultView {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!

    func configure(from movie: Movie) {
        nameLabel.text = movie.name
        if let image = movie.image {
            imageView.image = UIImage(data: image)
        }
    }
}
