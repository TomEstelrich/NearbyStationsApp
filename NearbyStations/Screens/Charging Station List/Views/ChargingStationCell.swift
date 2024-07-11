//
//  ChargingStationCell.swift
//  NearbyStations
//
//  Created by Tom Estelrich on 11.07.2024.
//

import SwiftUI

//MARK: ChargingStationCell

struct ChargingStationCell: View {

    // MARK: Lifecycle

    init(station: EVSEDataModel.Station) {
        self.station = station
    }

    // MARK: Internal

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Image(systemName: stationImage)
                    .font(.footnote)

                Text(station.id)
                    .font(.headline)
            }
            .fontWeight(.semibold)
            .foregroundStyle(stationColor)
            .padding(.bottom, 8)

            HStack {
                Text("Status: ")
                    .foregroundStyle(Color.gray)

                Text(station.status)
                    .fontWeight(.semibold)
            }

            HStack {
                Text("Max. capacity: ")
                    .foregroundStyle(Color.gray)

                Text(station.maxCapacity?.description ?? "N/A")
                    .fontWeight(.semibold)
            }

            HStack {
                Text("Phone: ")
                    .foregroundStyle(Color.gray)

                Text(station.phoneNumber ?? "N/A")
                    .fontWeight(.semibold)
            }

            HStack {
                Text("Power: ")
                    .foregroundStyle(Color.gray)

                Text(station.power?.description ?? "0")
                    .fontWeight(.semibold)
            }

            HStack {
                Text("Renewable energy: ")
                    .foregroundStyle(Color.gray)

                Text(station.renewableEnergy ?? "N/A")
                    .fontWeight(.semibold)
            }
        }
        .font(.callout)
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    // MARK: Private

    private let station: EVSEDataModel.Station

    private var stationColor: Color {
        station.status == "Available" ? .green : .red
    }

    private var stationImage: String {
        station.status == "Available" ? SFSymbol.evCharger : SFSymbol.evChargerSlash
    }
}

// MARK: Preview

#Preview {
    let station = EVSEDataModel.Station(
        id: "01231231231",
        coordinates: .zurich,
        status: "Available",
        phoneNumber: "+41 00 000 00 00",
        power: 100,
        maxCapacity: 43,
        renewableEnergy: "Yes"
    )

    return ChargingStationCell(station: station)
}
