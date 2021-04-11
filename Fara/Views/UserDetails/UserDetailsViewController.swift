//
//  UserDetailsViewController.swift
//  Fara
//
//  Created by Paweł Zgoda-Ferchmin on 10/04/2021.
//

import UIKit
import RxCocoa
import RxSwift

class UserDetailsViewController: UIViewController {
    
    @IBOutlet private var backButton: UIButton!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        backButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                        self.navigationController?.popViewController(animated: true) })
            .disposed(by: disposeBag)
    }
}
