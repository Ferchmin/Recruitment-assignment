//
//  FAQuery.swift
//  Fara
//
//  Created by Paweł Zgoda-Ferchmin on 10/04/2021.
//

import Foundation

protocol FAQuery {
    associatedtype ResultType: Decodable

    var url: URL { get }
    var parameters: [String: Any] { get }
    var method: HttpMethod { get }
}

extension FAQuery {
    var parameters: [String: Any] { [:] }
}

enum HttpMethod: String {
    case get
    case post
    case patch
    case put
    case delete
}
