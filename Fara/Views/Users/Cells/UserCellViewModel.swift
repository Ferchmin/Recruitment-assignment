//
//  UserCellViewModel.swift
//  Fara
//
//  Created by Paweł Zgoda-Ferchmin on 11/04/2021.
//

import Foundation
import RxSwift

class UserCellViewModel {

    public var name: Observable<String> { model.map { $0.name } }
    public var address: Observable<String> {
        model.map { $0.address.city }
    }
    public var user: Observable<FAUser> { model }

    private let model: Observable<FAUser>

    init(model: FAUser) {
        self.model = .just(model)
    }
}
