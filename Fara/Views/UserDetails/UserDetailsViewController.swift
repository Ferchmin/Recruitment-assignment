//
//  UserDetailsViewController.swift
//  Fara
//
//  Created by Paweł Zgoda-Ferchmin on 10/04/2021.
//

import UIKit
import RxCocoa
import RxSwift
import MapKit

class UserDetailsViewController: UIViewController {

    @IBOutlet private var mapView: MKMapView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var addressLabel: UILabel!
    @IBOutlet private var emailLabel: UILabel!
    @IBOutlet private var phoneLabel: UILabel!
    @IBOutlet private var companyLabel: UILabel!
    @IBOutlet private var backButton: UIButton!

    var mainViewModel: UserDetailsViewModel?
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let viewModel = mainViewModel else { return }
        bind(viewModel)
        bindView(with: viewModel)
    }

    private func bind(_ viewModel: UserDetailsViewModel) {
        viewModel.coordinates
            .delay(.milliseconds(500), scheduler: MainScheduler.instance)
            .compactMap { coordinate -> MKPointAnnotation? in
                guard let latitude = coordinate.latitude,
                      let longitude = coordinate.longitude else { return nil }
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                return annotation
            }
            .subscribe(onNext: { [unowned self] annotation in
                self.mapView.addAnnotation(annotation)
                let span = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
                let region = MKCoordinateRegion(center: annotation.coordinate, span: span)
                //let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 1500, longitudinalMeters: 1500)
                self.mapView.setRegion(region, animated: true)
            })
            .disposed(by: disposeBag)

        viewModel.name.bind(to: nameLabel.rx.text).disposed(by: disposeBag)
        viewModel.address.bind(to: addressLabel.rx.text).disposed(by: disposeBag)
        viewModel.email
            .map { email -> NSAttributedString in
                let range = (email as NSString).range(of: "Email:")
                return email.bold(range: range)
            }
            .bind(to: emailLabel.rx.attributedText)
            .disposed(by: disposeBag)
        viewModel.phone
            .map { phone -> NSAttributedString in
                let range = (phone as NSString).range(of: "Phone:")
                return phone.bold(range: range)
            }
            .bind(to: phoneLabel.rx.attributedText)
            .disposed(by: disposeBag)
        viewModel.company
            .map { company -> NSAttributedString in
                let range = (company as NSString).range(of: "Company:")
                return company.bold(range: range)
            }
            .bind(to: companyLabel.rx.attributedText)
            .disposed(by: disposeBag)
    }

    private func bindView(with viewModel: UserDetailsViewModel) {
        backButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                        self.navigationController?.popViewController(animated: true) })
            .disposed(by: disposeBag)
    }
}

extension UserDetailsViewController: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        guard annotationView != nil else {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            return annotationView
        }

        annotationView?.annotation = annotation

        return annotationView
    }
}

private extension String {
    func bold(range: NSRange) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        attributedString.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 14), range: range)
        return attributedString
    }
}
