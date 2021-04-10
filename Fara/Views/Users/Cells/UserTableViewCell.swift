//
//  UserTableViewCell.swift
//  Fara
//
//  Created by Paweł Zgoda-Ferchmin on 10/04/2021.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    static var cellIdentifier: String { String(describing: self) }

    override var reuseIdentifier: String { Self.cellIdentifier }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
