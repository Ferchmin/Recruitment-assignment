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

    private typealias DataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, UserCellViewModel>>

    private func bind(_ viewModel: UsersViewModel) {

        let dataSource = DataSource { _, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.cellIdentifier, for: indexPath)
            (cell as? UserTableViewCell)?.mainViewModel = item
            return cell
        }

        viewModel.dataSource.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)

        tableView.rx.modelSelected(UserCellViewModel.self)
            .flatMapLatest { $0.user }
            .subscribe(onNext: { [unowned self] user in
                guard let viewController = UIStoryboard(name: "UserDetails",
                                                        bundle: Bundle.main)
                        .instantiateInitialViewController() as? UserDetailsViewController
                else { return }

                viewController.mainViewModel = UserDetailsViewModel(model: user)
                self.navigationController?.pushViewController(viewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
}

