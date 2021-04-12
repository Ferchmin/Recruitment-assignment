//
//  Config.swift
//  Fara
//
//  Created by Paweł Zgoda-Ferchmin on 10/04/2021.
//

import Foundation

struct Config {

    private static let apiBaseUrl = "http://jsonplaceholder.typicode.com"

    static var baseUrl: URL {
        guard let url = URL(string: apiBaseUrl) else { fatalError("Base URL invalid.") }
        return url
    }
}
