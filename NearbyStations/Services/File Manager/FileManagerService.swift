//
//  FileManagerService.swift
//  NearbyStations
//
//  Created by Tom Estelrich on 11.07.2024.
//

import Foundation

// MARK: FileManagerService

final class FileManagerService {

    // MARK: Internal

    func save(_ dataModel: EVSEDataModel) throws {
        guard let fileURL else { throw FileManagerError.invalidFileURL }

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let data = try encoder.encode(dataModel)
        try data.write(to: fileURL, options: [.atomicWrite])
    }

    func load() throws -> EVSEDataModel? {
        guard let fileURL else { throw FileManagerError.invalidFileURL }

        let data = try Data(contentsOf: fileURL)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(EVSEDataModel.self, from: data)
    }

    func delete() throws {
        guard let fileURL else { throw FileManagerError.invalidFileURL }
        try FileManager.default.removeItem(at: fileURL)
    }

    // MARK: Private

    private var fileURL: URL? {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        return documentsDirectory?.appendingPathComponent("EVSEData.json")
    }
}
