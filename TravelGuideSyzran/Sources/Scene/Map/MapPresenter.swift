//
//  MapPresenter.swift
//  TravelGuideSyzran
//
//  Created by Artem Mushtakov on 05.04.2022.
//

import Foundation
import MapKit

final class MapPresenter: MapPresenterInputProtocol {

    // MARK: Properties

    private weak var view: MapPresenterOutputProtocol?
    var locationManager: CLLocationManager?

    required init(view: MapPresenterOutputProtocol) {
        self.view = view
        setupLocationManager()
        checkLocationEnable()
    }

    // MARK: - Setup Location

    fileprivate func setupLocationManager() {
        guard let locationManager = locationManager else { return }
        locationManager.delegate = view.self as? CLLocationManagerDelegate
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    // Функция использования геопозиции
    fileprivate func checkLocationEnable() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            guard let mapView = view?.mapView else { return }
            guard let locationManager = locationManager else { return }
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
