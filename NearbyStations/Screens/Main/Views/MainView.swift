//
//  MainView.swift
//  NearbyStations
//
//  Created by Tom Estelrich on 10.07.2024.
//

import SwiftUI

// MARK: MainView

struct MainView: View {

    var body: some View {
        TabView {
            UserLocationMapView()
                .tabItem { Label("Map", systemImage: SFSymbol.map) }

            ChargingStationListView()
                .tabItem { Label("EV Stations", systemImage: SFSymbol.evCharger) }
        }
    }
}

// MARK: Preview

#Preview {
    MainView()
}
