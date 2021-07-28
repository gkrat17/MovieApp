//
//  SimilarMovieView.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/28/21.
//

import UIKit

final class SimilarMovieView: DefaultView {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!

    func confugure(from model: SimilarMovieViewModel) {
        nameLabel.text = model.name
        imageView.image = {
            if let image = model.image {
                return UIImage(data: image)
            }
            return UIImage(named: "Movie")
        }()
    }
}
