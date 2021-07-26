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

        let request2 = RequestBuilder(host: Bundle.main.resourceUrl, apiKey: nil)
            .set(method: .image(id: "/bZGAX8oMDm3Mo5i0ZPKh9G2OcaO.jpg"))
            .build()

        print(request2)
        print("")
    }


}

