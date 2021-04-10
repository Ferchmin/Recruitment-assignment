//
//  Loadable.swift
//  Fara
//
//  Created by Paweł Zgoda-Ferchmin on 10/04/2021.
//

import Foundation
import UIKit

protocol LoadableCell: UITableViewCell {
    static var cellIdentifier: String { get }
}

extension LoadableCell {
    static var cellIdentifier: String { String(describing: self) }
    var reuseIdentifier: String { Self.cellIdentifier }
}
