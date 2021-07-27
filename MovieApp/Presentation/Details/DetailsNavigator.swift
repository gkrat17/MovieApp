//
//  DetailsNavigator.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/27/21.
//

import Foundation

protocol DetailsNavigator {}

final class DefaultDetailsNavigator: DetailsNavigator {
    private weak var vc: DetailsViewController?

    init(vc: DetailsViewController) {
        self.vc = vc
    }
}
