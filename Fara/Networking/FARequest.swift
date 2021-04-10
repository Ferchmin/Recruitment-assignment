//
//  FARequest.swift
//  Fara
//
//  Created by Paweł Zgoda-Ferchmin on 10/04/2021.
//

import Foundation

protocol FARequest {
    var method: HttpMethod { get }
    var path: String { get }
    var parameters: [String : String] { get }
}

extension FARequest {
    func request(with baseURL: URL) -> URLRequest {
        guard var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL components")
        }

        components.queryItems = parameters.map {
            URLQueryItem(name: String($0), value: String($1))
        }

        guard let url = components.url else {
            fatalError("Could not get url")
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}

class UserRequest: FARequest {
    var method: HttpMethod { .get }
    var path: String { "" }
    var parameters: [String : String] { [:] }
}

//class MARequest<Query> where Query: FAQuery {
//
//    public var result: RequestResult = .error(nil)
//
//    private var task: AnyCancellable?
//
//    init(query: Query) {
//        var request = URLRequest(url: query.url)
//        request.addValue("5", forHTTPHeaderField: "itemsPerPage")
//        request.addValue("1", forHTTPHeaderField: "page")
//
//        let tesk = URLSession.shared.dataTaskPublisher(for: request)
//            .map { $0.data }
//            .decode(type: Query.ResultType.self, decoder: JSONDecoder())
//            .receive(on: RunLoop.main)
//            .map { RequestResult.result($0) }
//            .eraseToAnyPublisher()
//
//
//        task = URLSession.shared.dataTaskPublisher(for: request)
//            .map { $0.data }
//            .decode(type: String.self, decoder: JSONDecoder())
//            .replaceError(with: "")
//            .eraseToAnyPublisher()
//            .receive(on: RunLoop.main)
//            .map { RequestResult.result($0) }
//            .assign(to: \.result, on: self)
//    }
//
//    enum RequestResult {
//        typealias ResultType = Decodable
//
//        case error(String?)
//        case result(ResultType)
//    }
//}
