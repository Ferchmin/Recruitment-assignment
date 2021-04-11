//
//  UsersViewModel.swift
//  Fara
//
//  Created by Paweł Zgoda-Ferchmin on 11/04/2021.
//

import Foundation
import RxCocoa
import RxDataSources
import RxSwift

class UsersViewModel {

    public var dataSource: Observable<[SectionModel<String, UserCellViewModel>]> {
        model.map { $0.map { UserCellViewModel(model: $0) } }
            .map { [SectionModel(model: "", items: $0)] }
    }

    private let disposeBag = DisposeBag()

    private let model: Observable<[FAUser]>

    init() {
        self.model = Observable.just(())
            .map { UsersQuery() }
            .flatMapLatest { FARequest(query: $0).send() }
            .share(replay: 1, scope: .forever)
    }
}
