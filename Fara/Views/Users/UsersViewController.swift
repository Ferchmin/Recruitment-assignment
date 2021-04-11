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
            tableView.contentInset.top = 20.0
            tableView.register(UINib(nibName: UserTableViewCell.cellIdentifier, bundle: nil),
                               forCellReuseIdentifier: UserTableViewCell.cellIdentifier)
        }
    }

    private let mainViewModel = UsersViewModel()

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        bind(mainViewModel)
    }

    private func bind(_ viewModel: UsersViewModel) {
        viewModel.users
            .bind(to: tableView.rx.items(cellIdentifier: UserTableViewCell.cellIdentifier)) { _, viewModel, cell in
                (cell as? UserTableViewCell)?.mainViewModel = viewModel
            }
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(UserCellViewModel.self)
            .flatMap { $0.user }
            .subscribe(onNext: { [unowned self] user in
                guard let viewController = UIStoryboard(name: "UserDetails",
                                                        bundle: Bundle.main)
                        .instantiateInitialViewController() as? UserDetailsViewController
                else { return }

                self.navigationController?.pushViewController(viewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

