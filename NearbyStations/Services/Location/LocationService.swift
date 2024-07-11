//
//  LocationService.swift
//  NearbyStations
//
//  Created by Tom Estelrich on 11.07.2024.
//

import MapKit

// MARK: LocationService

final class LocationService: NSObject, CLLocationManagerDelegate {

    @Published var authorizationStatus: CLAuthorizationStatus

    private var locationManager: CLLocationManager

    override init() {
        self.locationManager = CLLocationManager()
        self.authorizationStatus = locationManager.authorizationStatus
        super.init()

        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkAuthorizationStatus()
    }

    func checkAuthorizationStatus() {
        switch locationManager.authorizationStatus {
        case .notDetermined: locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways: locationManager.startUpdatingLocation()
        case .restricted, .denied: break
        @unknown default: break
        }
    }
}

// MARK: ObservableObject

extension LocationService: ObservableObject {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorizationStatus = status
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.stopUpdatingLocation()
        }
    }
}
