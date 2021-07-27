//
//  DefaultView.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/27/21.
//

import UIKit

class DefaultView: UIView {
    @IBOutlet weak var contentView: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    private func initialize() {
        Bundle.main.loadNibNamed(className, owner: self, options: nil)

        guard let content = contentView else {
            fatalError("contentView not set")
        }

        content.frame = self.bounds
        content.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        addSubview(content)
    }
}
