//
//  ChargingStationListView.swift
//  NearbyStations
//
//  Created by Tom Estelrich on 10.07.2024.
//

import SwiftUI

// MARK: ChargingStationListView

struct ChargingStationListView: View {

    var body: some View {
        NavigationStack {
            List {
                ForEach(0...10, id: \.self) { number in
                    Text(number.description)
                }
            }
            .navigationTitle("Charging stations")
        }
    }
}

// MARK: Preview

#Preview {
    ChargingStationListView()
}
