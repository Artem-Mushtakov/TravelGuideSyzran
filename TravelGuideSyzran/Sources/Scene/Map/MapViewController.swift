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

    var  presenter: MapPresenter?
    fileprivate var locationManager = CLLocationManager()

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupNavigationTitle()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let presenterLocationManager = presenter?.locationManager else { return }
        locationManager = presenterLocationManager
    }
    
    // MARK: - UIElements
    
    internal lazy var mapView = MKMapView().then {
        $0.layer.cornerRadius = 10
    }

    private lazy var myGeolocationButton = UIButton().then {
        $0.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        $0.tintColor = .purple
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
            $0.top.equalToSuperview().offset(10)
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

    // MARK: - Setup Location delegate

extension MapViewController: CLLocationManagerDelegate {

    // Обновление карты что бы следить за пользователем
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 10000, longitudinalMeters: 10000)
            mapView.setRegion(region, animated: true)
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        presenter?.checkLocationAuthUser(locationManager: self.locationManager, mapView: self.mapView)
    }
}
