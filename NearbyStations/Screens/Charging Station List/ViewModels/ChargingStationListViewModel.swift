//
//  ChargingStationListViewModel.swift
//  NearbyStations
//
//  Created by Tom Estelrich on 11.07.2024.
//

import Foundation

// MARK: ChargingStationListViewModel

@MainActor @Observable final class ChargingStationListViewModel {

    // MARK: Lifecycle

    init(chargingStations: [EVSEDataModel.Station] = [], fileManagerService: FileManagerService = FileManagerService()) {
        self.chargingStations = chargingStations
        self.fileManagerService = fileManagerService
    }

    // MARK: Internal

    func loadPersistedStations() {
        guard let loadedDataModel = try? fileManagerService.load() else { return }
        chargingStations = loadedDataModel.stations.sorted(by: { $0.power ?? 0 > $1.power ?? 0 })
    }

    // MARK: Private

    private(set) var chargingStations: [EVSEDataModel.Station]
    private var fileManagerService = FileManagerService()

}
