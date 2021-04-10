//
//  UserTableViewCell.swift
//  Fara
//
//  Created by Paweł Zgoda-Ferchmin on 10/04/2021.
//

import UIKit

class UserTableViewCell: UITableViewCell, LoadableCell {

    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var addressLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
