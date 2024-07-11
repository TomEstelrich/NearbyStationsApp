//
//  UserLocationMapView.swift
//  NearbyStations
//
//  Created by Tom Estelrich on 10.07.2024.
//

import MapKit
import SwiftUI

// MARK: UserLocationMapView

struct UserLocationMapView: View {

    // MARK: Lifecycle

    @MainActor init(viewModel: UserLocationMapViewModel = UserLocationMapViewModel()) {
        self.viewModel = viewModel
    }

    // MARK: Internal
    
    var body: some View {
        ZStack(alignment: .top) {
            Map(position: $viewModel.position, interactionModes: [.rotate]) {
                ForEach(viewModel.dataModel.stations) { station in
                    Annotation(station.id, coordinate: station.coordinates) {
                        Image(systemName: station.status == "Available" ? SFSymbol.evCharger : SFSymbol.evChargerSlash)
                            .foregroundStyle(.white)
                            .padding(8)
                            .background(station.status == "Available" ? .green : .red)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
            }
            .mapStyle(.standard(pointsOfInterest: .excludingAll))
            .onMapCameraChange { context in
                Task { await viewModel.refreshStationsIfNeeded(from: context.camera.centerCoordinate) }
            }
            .edgesIgnoringSafeArea(.top)

            Label(viewModel.dataModel.lastUpdate?.formatted(date: .abbreviated, time: .shortened) ?? "Not updated", systemImage: SFSymbol.clock)
                .font(.footnote)
                    .foregroundStyle(Color.primary)
                    .padding(8)
                    .background(Color(.systemBackground))
                    .clipShape(Capsule())
                    .animation(.easeInOut, value: viewModel.dataModel.lastUpdate)
        }
        .task {
            viewModel.loadPersistedStations()
        }
    }

    // MARK: Private

    @State private var viewModel: UserLocationMapViewModel

}

// MARK: Preview

#Preview {
    UserLocationMapView()
}
