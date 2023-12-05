//
//  EquipmentOryxJSON.swift
//  LossLogbook
//
//  Created by Illia Rahozin on 26.08.2023.
//

import UIKit

// MARK: - EquipmentElement
struct EquipmentOryxJSON: Codable, TableRepresentable {
    
    var equipmentOryx, model: String
    var manufacturer: Manufacturer
    var lossesTotal: Int
    var equipmentUa: EquipmentUa

    enum CodingKeys: String, CodingKey {
        case equipmentOryx = "equipment_oryx"
        case model, manufacturer
        case lossesTotal = "losses_total"
        case equipmentUa = "equipment_ua"
    }
    
    func getDetailInfo() -> String {
        let manufacturerString = "Manufacturer: \(manufacturer.getCountryWithEmoji)"
        let modelString = "Model: \(model)"
        let lossesString = "Losses: \(lossesTotal)"
        let equipmentUaString = "Equipment UA: \(equipmentUa.rawValue)"
        
        let fullDetailString = "\(manufacturerString)\n\(modelString)\n\(lossesString)\n\(equipmentUaString)"
        
        return fullDetailString
    }
}

enum EquipmentUa: String, Codable, CaseIterable {
    case aircrafts = "Aircrafts"
    case antiAircraftWarfareSystems = "Anti-aircraft Warfare Systems"
    case armouredPersonnelCarriers = "Armoured Personnel Carriers"
    case artillerySystems = "Artillery Systems"
    case helicopters = "Helicopters"
    case multipleRocketLaunchers = "Multiple Rocket Launchers"
    case specialEquipment = "Special Equipment"
    case tanks = "Tanks"
    case unmannedAerialVehicles = "Unmanned Aerial Vehicles"
    case vehicleAndFuelTank = "Vehicle and Fuel Tank"
    case warshipsBoats = "Warships, Boats"
    
    var image: UIImage? {
        switch self {
        case .aircrafts:
            return UIImage(named: "Aircrafts")
        case .antiAircraftWarfareSystems:
            return UIImage(named: "Anti-aircraft-Warfare-Systems")
        case .armouredPersonnelCarriers:
            return UIImage(named: "Armoured-Personnel-Carriers")
        case .artillerySystems:
            return UIImage(named: "Artillery-Systems")
        case .helicopters:
            return UIImage(named: "Helicopters")
        case .multipleRocketLaunchers:
            return UIImage(named: "Multiple-Rocket-Launchers")
        case .specialEquipment:
            return UIImage(named: "Special-Equipment")
        case .tanks:
            return UIImage(named: "Tanks")
        case .unmannedAerialVehicles:
            return UIImage(named: "Unmanned-Aerial-Vehicles")
        case .vehicleAndFuelTank:
            return UIImage(named: "Vehicle-and-Fuel-Tank")
        case .warshipsBoats:
            return UIImage(named: "Warships-Boats")
        }
    }
}

enum Manufacturer: String, Codable {
    case iran = "Iran"
    case israel = "Israel"
    case italy = "Italy"
    case poland = "Poland"
    case russia = "Russia"
    case theCzechRepublic = "the Czech Republic"
    case theSovietUnion = "the Soviet Union"
    
    var getCountryWithEmoji: String {
        if let countryCode = countryCode(for: self.rawValue) {
            if self == .russia {
                return "💩 Parasha"
            } else {
                let emoji = emojiFlag(for: countryCode)
                return ("\(emoji) \(self.rawValue) ")
            }
        } else {
            return self.rawValue
        }
    }

    private func countryCode(for countryName: String) -> String? {
        let locales = Locale.availableIdentifiers.map { Locale(identifier: $0) }
        
        for locale in locales {
            if let country = locale.localizedString(forRegionCode: locale.regionCode ?? ""),
               countryName.range(of: country, options: .caseInsensitive) != nil {
                return locale.regionCode
            }
        }
        
        return nil
    }
    
    private func emojiFlag(for countryCode: String) -> String {
        let country = countryCode.uppercased()
        guard country.count == 2 else {
            return ""
        }
        
        var flag = ""
        for scalar in country.unicodeScalars {
            if let scalarUnicode = UnicodeScalar(UInt32(scalar.value) + 127397) {
                flag.append(String(scalarUnicode))
            }
        }
        
        return flag
    }
    
}
