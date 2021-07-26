//
//  Bundle+Extension.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/27/21.
//

import Foundation

extension Bundle {
    var serviceUrl: String { infoDictionary?["SERVICE_URL"] as? String ?? "" }
    var resourceUrl: String { infoDictionary?["RESOURCE_URL"] as? String ?? "" }
    var apiKey: String { infoDictionary?["API_KEY"] as? String ?? "" }
}
