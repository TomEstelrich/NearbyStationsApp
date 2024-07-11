//
//  ChargingStationListView.swift
//  NearbyStations
//
//  Created by Tom Estelrich on 10.07.2024.
//

import SwiftUI

// MARK: ChargingStationListView

struct ChargingStationListView: View {

    // MARK: Lifecycle

    @MainActor init(viewModel: ChargingStationListViewModel = ChargingStationListViewModel()) {
        self.viewModel = viewModel
    }

    // MARK: Private

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.chargingStations) { station in
                    ChargingStationCell(station: station)
                }
            }
            .navigationTitle("EV Stations")
        }
        .onAppear {
            viewModel.loadPersistedStations()
        }
    }

    // MARK: Private
    
    @State private var viewModel: ChargingStationListViewModel

}

// MARK: Preview

#Preview {
    ChargingStationListView()
}
