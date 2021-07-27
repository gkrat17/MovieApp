//
//  DetailsFactory.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/27/21.
//

import Foundation

protocol DetailsFactory {
    func make(with params: DetailsParams) -> DetailsViewController
}

final class DefaultDetailsFactory: DetailsFactory {
    func make(with params: DetailsParams) -> DetailsViewController {
        let vc = DetailsViewController.getInstance()
        let navigator: DetailsNavigator = DefaultDetailsNavigator(vc: vc)
        let presenter: DetailsPresenter = DefaultDetailsPresenter(params: params, view: vc, navigator: navigator)
        vc.presenter = presenter
        return vc
    }
}
