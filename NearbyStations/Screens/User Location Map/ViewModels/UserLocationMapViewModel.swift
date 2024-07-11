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
        latestBoundingBox: BoundingBox? = nil,
        networkService: APINetworkService = APINetworkService(),
        locationService: LocationService = LocationService(),
        fileManagerService: FileManagerService = FileManagerService()
    ) {
        self.position = position
        self.dataModel = dataModel
        self.latestBoundingBox = latestBoundingBox
        self.networkService = networkService
        self.locationService = locationService
        self.fileManagerService = fileManagerService
    }

    // MARK: Internal

    var position: MapCameraPosition

    func loadPersistedStations() {
        guard let persistedDataModel = try? fileManagerService.load() else { return }
        dataModel = persistedDataModel
    }

    func refreshStationsIfNeeded(from coordinate: CLLocationCoordinate2D) async {
        guard let latestBoundingBox,
              networkService.isCoordinateInsideBoundingBox(latitude: coordinate.latitude, longitude: coordinate.longitude, boundingBox: latestBoundingBox) else {
            do {
                let dataModelDTO = try await networkService.fetchStations(latitude: coordinate.latitude, longitude: coordinate.longitude)
                dataModel = EVSEDataModelFactory.build(from: dataModelDTO)
                try fileManagerService.save(dataModel)

                latestBoundingBox = EVSEDataModelHelper.calculateBoundingBox(latitude: coordinate.latitude, longitude: coordinate.longitude, distanceKm: 1)
                print(dataModel.stations.count)
            } catch {
                print(error.localizedDescription)
            }

            return
        }
    }

    // MARK: Private

    private(set) var dataModel: EVSEDataModel
    private(set) var latestBoundingBox: BoundingBox?
    private var networkService: APINetworkService
    private var locationService: LocationService
    private var fileManagerService: FileManagerService

}
