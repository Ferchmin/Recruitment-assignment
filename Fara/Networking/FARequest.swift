//
//  FARequest.swift
//  Fara
//
//  Created by Paweł Zgoda-Ferchmin on 10/04/2021.
//

import Foundation
import RxSwift

class FARequest<Query: FAQuery> {

    private let query: Query

    private var request: URLRequest {
        guard var components = URLComponents(url: query.url, resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL components")
        }

        components.queryItems = query.parameters.map {
            URLQueryItem(name: $0, value: String(describing: $1))
        }

        guard let url = components.url else {
            fatalError("Could not get url")
        }

        var request = URLRequest(url: url)
        request.httpMethod = query.method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }

    func send() -> Observable<Query.ResultType> {
        URLSession.shared.rx.data(request: request)
            .map { try JSONDecoder().decode(Query.ResultType.self, from: $0) }
            .observe(on: MainScheduler.asyncInstance)
    }

    init(query: Query) {
        self.query = query
    }
}
