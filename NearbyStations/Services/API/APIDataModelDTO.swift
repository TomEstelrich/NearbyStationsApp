//
//  APIDataModelDTO.swift
//  NearbyStations
//
//  Created by Tom Estelrich on 11.07.2024.
//

// MARK: APIDataModelDTO

struct APIDataModelDTO: Codable {

    let type: String?
    let features: [Feature]?
    let timeStamp: String?

    /// Feature
    struct Feature: Codable {

        let id: String
        let geometry: Geometry?
        let properties: FeatureProperties?

        /// Geometry
        struct Geometry: Codable {

            let coordinates: [Double]

        }

        /// FeatureProperties
        struct FeatureProperties: Codable {

            let id: String
            let evseStatus: EvseStatus?
            let phoneNumber: String?
            let chargingFacilities: [ChargingFacility]?
            let maxCapacity: Int?
            let renewableEnergy: Bool?

            enum CodingKeys: String, CodingKey {

                case id = "_id"
                case evseStatus = "EvseStatus"
                case phoneNumber = "HotlinePhoneNumber"
                case chargingFacilities = "ChargingFacilities"
                case maxCapacity = "MaxCapacity"
                case renewableEnergy = "RenewableEnergy"

            }

            /// EvseStatus
            enum EvseStatus: String, Codable {

                case available = "Available"
                case occupied = "Occupied"
                case outOfService = "OutOfService"
                case unknown = "Unknown"

            }

            /// ChargingFacility
            struct ChargingFacility: Codable {

                let power: Double?

                enum CodingKeys: String, CodingKey {

                    case power = "Power"

                }
            }
        }
    }
}
