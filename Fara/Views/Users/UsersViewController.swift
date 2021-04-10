//
//  ViewController.swift
//  Fara
//
//  Created by Paweł Zgoda-Ferchmin on 10/04/2021.
//

import UIKit
import RxCocoa
import RxDataSources
import RxSwift

class UsersViewController: UIViewController {

    @IBOutlet private var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: UserTableViewCell.cellIdentifier, bundle: nil),
                               forCellReuseIdentifier: UserTableViewCell.cellIdentifier)

            tableView.contentInset.top = 20.0
        }
    }

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
            .bind(to: tableView.rx.items(cellIdentifier: UserTableViewCell.cellIdentifier)) { index, model, cell in }
            .disposed(by: disposeBag)

    }
}

