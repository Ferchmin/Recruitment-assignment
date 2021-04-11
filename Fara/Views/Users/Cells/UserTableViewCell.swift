//
//  UserTableViewCell.swift
//  Fara
//
//  Created by Paweł Zgoda-Ferchmin on 10/04/2021.
//

import UIKit
import RxCocoa
import RxSwift

class UserTableViewCell: UITableViewCell, LoadableCell {

    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var addressLabel: UILabel!

    var mainViewModel: UserCellViewModel? {
        didSet {
            guard let viewModel = mainViewModel else { return }
            bind(viewModel)
        }
    }

    private let disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private func bind(_ viewModel: UserCellViewModel) {
        viewModel.name.bind(to: nameLabel.rx.text).disposed(by: disposeBag)
        viewModel.address.bind(to: addressLabel.rx.text).disposed(by: disposeBag)
    }
}
