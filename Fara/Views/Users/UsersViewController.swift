//
//  ViewController.swift
//  Fara
//
//  Created by Paweł Zgoda-Ferchmin on 10/04/2021.
//

import UIKit
import RxSwift
import RxCocoa

class UsersViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        sendQuery()
        // Do any additional setup after loading the view.
    }

    private let disposeBag = DisposeBag()

    private func sendQuery() {
        Observable.just(())
            .map { UsersQuery() }
            .flatMapLatest { FARequest(query: $0).send() }
            .subscribe(onNext: { result in
                result.forEach { print("\($0)") }
            })
            .disposed(by: disposeBag)
    }
}

