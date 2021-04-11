//
//  UserDetailsViewModel.swift
//  Fara
//
//  Created by Paweł Zgoda-Ferchmin on 11/04/2021.
//

import Foundation
import RxSwift

class UserDetailsViewModel {

    public var name: Observable<String> { model.map { $0.name } }
    public var address: Observable<String> {
        model.map {
            "\($0.address.street)\n\($0.address.zipCode) \($0.address.city)"
        }
    }
    public var email: Observable<String> { model.map { "Email: \($0.email)" } }
    public var phone: Observable<String> { model.map { "Phone: \($0.phone)" } }
    public var company: Observable<String> { model.map { "Company: \($0.company.name)" } }
    public var coordinates: Observable<FACoordinates> { model.map { $0.address.coordinates } }
    
    private let model: Observable<FAUser>

    init(model: FAUser) {
        self.model = .just(model)
    }
}
