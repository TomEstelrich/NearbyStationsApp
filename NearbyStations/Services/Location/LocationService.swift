//
//  LocationService.swift
//  NearbyStations
//
//  Created by Tom Estelrich on 11.07.2024.
//

import MapKit

// MARK: LocationService

@Observable final class LocationService: NSObject, CLLocationManagerDelegate {

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkLocationAuthorization()
    }

    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.currentLocation = location.coordinate
        print("😀 Current Location", self.currentLocation)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorizationStatus = status
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.stopUpdatingLocation()
        }
    }

    // MARK: Private

    private(set) var currentLocation: CLLocationCoordinate2D?
    private(set) var authorizationStatus: CLAuthorizationStatus?
    private var locationManager = CLLocationManager()

}
