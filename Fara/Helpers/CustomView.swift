//
//  UIView+Extensions.swift
//  Fara
//
//  Created by Paweł Zgoda-Ferchmin on 11/04/2021.
//

import Foundation
import UIKit

class CustomView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}

class CustomButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}
