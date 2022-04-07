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

final class MapViewController: UIViewController, MapPresenterOutputProtocol {

    // MARK: - Properties

    var presenter: MapPresenter?
    var locationManager = CLLocationManager()

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupNavigationTitle()
        locationManager.delegate = presenter
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - UIElements
    
    internal lazy var mapView = MKMapView().then {
        $0.layer.cornerRadius = 10
    }

    private lazy var myGeolocationButton = UIButton().then {
        $0.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        $0.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 30), forImageIn: .normal)
        $0.tintColor = .gray
        $0.addTarget(self, action: #selector(centerMapOnUserButtonClicked), for: .touchUpInside)
    }

    // MARK: - Setup Actions

    @objc func centerMapOnUserButtonClicked() {
        mapView.setUserTrackingMode( MKUserTrackingMode.follow, animated: true)
    }
    
    // MARK: - Setup view
    
    fileprivate func setupView() {
        view.addSubview(mapView)
        mapView.addSubview(myGeolocationButton)
    }
    
    fileprivate func setupConstraints() {
        
        mapView.snp.makeConstraints {
            $0.top.equalTo(view.snp_topMargin).offset(10)
            $0.bottom.equalTo(view.snp_bottomMargin).offset(-10)
            $0.leading.equalTo(10)
            $0.trailing.equalTo(-10)
        }

        myGeolocationButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-35)
            $0.trailing.equalToSuperview().offset(-10)
        }
    }

    fileprivate func setupNavigationTitle() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        title = "Карты"
    }

    // MARK: - Setup Alert

    func showAlertLocation(title: String, message: String?, url: String) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let settingsAction = UIAlertAction(title: "Настройки", style: .default) { _ in
            guard let url = URL(string: url) else { return }
            UIApplication.shared.open(url)
        }

        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)

        alert.addAction(settingsAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}
