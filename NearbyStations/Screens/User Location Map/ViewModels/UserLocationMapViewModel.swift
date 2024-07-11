//
//  UserLocationMapViewModel.swift
//  NearbyStations
//
//  Created by Tom Estelrich on 11.07.2024.
//

import MapKit
import SwiftUI

// MARK: UserLocationMapViewModel

@MainActor @Observable final class UserLocationMapViewModel: NSObject, CLLocationManagerDelegate {

    // MARK: Lifecycle

    init(
        position: MapCameraPosition = .userLocation(fallback: .automatic),
        dataModel: EVSEDataModel = EVSEDataModel(),
        locationService: LocationService = LocationService(),
        fileManagerService: FileManagerService = FileManagerService()
    ) {
        self.position = position
        self.dataModel = dataModel
        self.locationService = locationService
        self.fileManagerService = fileManagerService
    }

    // MARK: Internal

    var position: MapCameraPosition

    func fetchStations(latitude: Double?, longitude: Double?) async {
        guard let latitude, let longitude else { return }

        do {
            let dataModelDTO = try await APINetworkService.fetchStations(latitude: latitude, longitude: longitude)
            dataModel = EVSEDataModelFactory.build(from: dataModelDTO)
            try fileManagerService.save(dataModel)

            print(dataModel.stations.count)
            dataModel.stations.forEach { print($0.coordinates) }
        } catch {
            print(error.localizedDescription)
        }
    }

    func refreshStationsIfNeeded() {
        guard let latitude = position.region?.center.latitude,
              let longitude = position.region?.center.longitude
        else {
            return
        }

        let isCoordinateInsideBoundingBox = APINetworkService.isCoordinateInsideBoundingBox(latitude: latitude, longitude: longitude, distanceKm: 0.5)

        if !isCoordinateInsideBoundingBox {
            Task { @MainActor in
                await fetchStations(latitude: latitude, longitude: longitude)
            }
        }
    }

    // MARK: Private

    private(set) var dataModel: EVSEDataModel
    private var locationService: LocationService
    private var fileManagerService: FileManagerService

}
