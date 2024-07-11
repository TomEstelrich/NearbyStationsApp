//
//  String+Ext.swift
//  NearbyStations
//
//  Created by Tom Estelrich on 11.07.2024.
//

import Foundation

// MARK: String

extension String {

    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.date(from: self)
    }
}
