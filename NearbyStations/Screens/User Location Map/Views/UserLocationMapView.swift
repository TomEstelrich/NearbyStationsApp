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

    // MARK: Internal
    
    var body: some View {
        ZStack(alignment: .top) {
            Map(position: $viewModel.position, interactionModes: [.rotate]) {
                ForEach(viewModel.dataModel.chargingStations) { station in
                    Annotation(station.id, coordinate: station.coordinates) {
                        Image(systemName: SFSymbol.mappin)
                            .foregroundStyle(.black)
                            .padding()
                            .background(.red)
                            .clipShape(Circle())
                    }
                }
            }
            .mapStyle(.standard(pointsOfInterest: .excludingAll))
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
            await viewModel.fetchChargingStations(latitude: CLLocationCoordinate2D.home.latitude, longitude: CLLocationCoordinate2D.home.longitude)
        }
    }

    // MARK: Private

    @State private var viewModel = UserLocationMapViewModel()

}

// MARK: Preview

#Preview {
    UserLocationMapView()
}
