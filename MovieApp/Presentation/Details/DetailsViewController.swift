//
//  DetailsViewController.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/27/21.
//

import UIKit

final class DetailsViewController: UIViewController {
    var presenter: DetailsPresenter!

    static func getInstance() -> DetailsViewController {
        .init(nibName: className, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension DetailsViewController: DetailsView {
    func updateDetails(from movie: Movie) {
        
    }
}
