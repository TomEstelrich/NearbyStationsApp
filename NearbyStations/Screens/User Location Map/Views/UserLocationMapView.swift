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

    var body: some View {
        ZStack(alignment: .top) {
            let _ = Self._printChanges()

            Map()

            Label("Updated: \(Date.now.formatted(date: .abbreviated, time: .shortened))", systemImage: SFSymbol.clock)
                .font(.footnote)
                    .foregroundStyle(Color.primary)
                    .padding(8)
                    .background(Color(.systemBackground))
                    .clipShape(Capsule())
        }
    }
}

// MARK: Preview

#Preview {
    UserLocationMapView()
}
