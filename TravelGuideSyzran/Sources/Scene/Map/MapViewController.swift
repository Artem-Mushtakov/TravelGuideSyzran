//
//  MapViewController.swift
//  TravelGuideSyzran
//
//  Created by Artem Mushtakov on 05.04.2022.
//

import UIKit
import MapKit
import Then
import SnapKit

class MapViewController: UIViewController {

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupNavigationTitle()
    }

    // MARK: - View

    private lazy var mapView = MKMapView().then {
        $0.layer.cornerRadius = 10
    }

    // MARK: - Setup view

    private func setupView() {
        view.addSubview(mapView)
    }

    private func setupConstraints() {

        mapView.snp.makeConstraints {
            $0.top.equalTo(view.snp_topMargin).offset(10)
            $0.bottom.equalTo(view.snp_bottomMargin).offset(-10)
            $0.leading.equalTo(10)
            $0.trailing.equalTo(-10)
        }
    private func setupNavigationTitle() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        title = "Карты"
    }
    }
}
