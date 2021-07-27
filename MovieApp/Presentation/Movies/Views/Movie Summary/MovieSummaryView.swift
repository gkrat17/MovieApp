//
//  MovieSummaryView.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/27/21.
//

import UIKit

final class MovieSummaryView: DefaultView {
    @IBOutlet private weak var nameLabel: UILabel!

    func configure(from movie: Movie) {
        nameLabel.text = movie.name
    }
}
