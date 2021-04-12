//
//  User.swift
//  Fara
//
//  Created by Paweł Zgoda-Ferchmin on 10/04/2021.
//

import Foundation

struct FAUser: Codable {
    let id: Int
    let name: String
    let userName: String
    let email: String
    let phone: String
    let website: String
    let address: FAAddress
    let company: FACompany

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case userName = "username"
        case email
        case address
        case phone
        case website
        case company
    }
}

struct UsersQuery: FAQuery {
    typealias ResultType = [FAUser]

    var url: URL { Config.baseUrl.appendingPathComponent("/users") }
    var method: HttpMethod { .get }
}
