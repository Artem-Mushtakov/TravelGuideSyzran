//
//  MapPresenter.swift
//  TravelGuideSyzran
//
//  Created by Artem Mushtakov on 05.04.2022.
//

import Foundation
import MapKit

final class MapPresenter: NSObject, MapPresenterInputProtocol {

    // MARK: Properties

    private weak var view: MapPresenterOutputProtocol?

    required init(view: MapPresenterOutputProtocol) {
        super.init()
        self.view = view
        self.setupLocationManager()
        self.checkLocationEnable()
    }

    // MARK: - Setup Location

    fileprivate func setupLocationManager() {
        guard let locationManager = view?.locationManager else { return }
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    // Функция использования геопозиции
    fileprivate func checkLocationEnable() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            guard let mapView = view?.mapView else { return }
            guard let locationManager = view?.locationManager else { return }
            checkLocationAuthUser(locationManager: locationManager, mapView: mapView)
        } else {
            view?.showAlertLocation(title: "У Вас выключена геолокация",
                                    message: "Хотите включить?",
                                    url: "App-Prefs:root=LOCATION_SERVICES")
        }
    }

    // Функция разрешения геопозиции пользователя
    func checkLocationAuthUser(locationManager: CLLocationManager, mapView: MKMapView) {

        // Статусы состояния геопозиции вкл/выкл
        switch locationManager.authorizationStatus {
        case .restricted, .authorizedAlways:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
        case .denied:
            view?.showAlertLocation(title: "Вы запретили использование местоположения",
                                    message: "Хотите разрешить?",
                                    url: UIApplication.openSettingsURLString)
        default:
            fatalError()
        }
    }
}

extension MapPresenter: CLLocationManagerDelegate {

    // Обновление карты что бы следить за пользователем
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last?.coordinate {
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 10000, longitudinalMeters: 10000)
            guard let mapView = view?.mapView else { return }
            mapView.setRegion(region, animated: true)
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard let locationManager = view?.locationManager else { return }
        guard let mapView = view?.mapView else { return }
        checkLocationAuthUser(locationManager: locationManager, mapView: mapView)
    }
}
