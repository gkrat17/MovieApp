//
//  RootViewController.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/25/21.
//

import UIKit

class RootViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let request = RequestBuilder()
            .set(method: .popular)
            .set(page: 1)
            .build()

        print(request)
        print("")
    }


}

