//
//  MapPresenterProtocol.swift
//  TravelGuideSyzran
//
//  Created by Artem Mushtakov on 05.04.2022.
//

import Foundation
import MapKit

protocol MapPresenterOutputProtocol: AnyObject {
    var mapView: MKMapView { get set }
    func showAlertLocation(title: String, message: String?, url: String)
}

protocol MapPresenterInputProtocol {
    var locationManager: CLLocationManager? { get set }
    init(view: MapPresenterOutputProtocol)
}
