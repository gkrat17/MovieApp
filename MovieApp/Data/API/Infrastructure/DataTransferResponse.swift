//
//  DataTransferResponse.swift
//  MovieApp
//
//  Created by Giorgi Kratsashvili on 7/26/21.
//

import Foundation

/**
 Every Data Transfer Response *MUST* have functionallity of
 converting itself to Domain Entity.
 */
protocol DataTransferResponse {
    associatedtype Body: Codable
    associatedtype Entity
    static func entity(from body: Body) -> Entity
}
