//
//  UIViewController+Extension.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/29/21.
//

import UIKit

extension UIViewController {
    var isCompact: Bool {
        traitCollection.horizontalSizeClass == .compact &&
        traitCollection.verticalSizeClass != .compact
    }

    func showAlert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
