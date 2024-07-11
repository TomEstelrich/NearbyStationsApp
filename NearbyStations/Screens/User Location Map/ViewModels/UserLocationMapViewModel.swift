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
        position: MapCameraPosition = .userLocation(followsHeading: true, fallback: .camera(MapCamera(centerCoordinate: .zurich, distance: 10000))),
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

    func fetchChargingStations(latitude: Double?, longitude: Double?) async {
        guard let latitude, let longitude else { return }

        do {
            let dataModelDTO = try await APINetworkService.fetchChargingStations(latitude: latitude, longitude: longitude)
            dataModel = EVSEDataModelFactory.build(from: dataModelDTO)
            try fileManagerService.save(dataModel)

            print(dataModel.stations.count)
            dataModel.stations.forEach { print($0.coordinates) }
        } catch {
            print(error.localizedDescription)
        }
    }

    // MARK: Private

    private(set) var dataModel: EVSEDataModel
    private var locationService: LocationService
    private var fileManagerService: FileManagerService

}
