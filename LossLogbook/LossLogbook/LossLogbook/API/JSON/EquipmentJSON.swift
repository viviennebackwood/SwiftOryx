//
//  EquipmentJSON.swift
//  LossLogbook
//
//  Created by Illia Rahozin on 26.08.2023.
//

import Foundation

typealias Equipment = [EquipmentJSON]

struct EquipmentJSON: Codable, TableRepresentable {
    
    var date: String
    var day, aircraft, helicopter, tank: Int?
    var apc, fieldArtillery, mrl: Int?
    var militaryAuto, fuelTank: Int?
    var drone, navalShip, antiAircraftWarfare: Int?
    var specialEquipment, mobileSRBMSystem: Int?
    var greatestLossesDirection: String?
    var vehiclesAndFuelTanks, cruiseMissiles: Int?

    enum CodingKeys: String, CodingKey {
        case date, day, aircraft, helicopter, tank
        case apc = "APC"
        case fieldArtillery = "field artillery"
        case mrl = "MRL"
        case militaryAuto = "military auto"
        case fuelTank = "fuel tank"
        case drone
        case navalShip = "naval ship"
        case antiAircraftWarfare = "anti-aircraft warfare"
        case specialEquipment = "special equipment"
        case mobileSRBMSystem = "mobile SRBM system"
        case greatestLossesDirection = "greatest losses direction"
        case vehiclesAndFuelTanks = "vehicles and fuel tanks"
        case cruiseMissiles = "cruise missiles"
    }
}


extension EquipmentJSON {
    mutating func update(with correction: EquipmentJSON) {
        date = correction.date
        day += correction.day
        aircraft += correction.aircraft
        helicopter += correction.helicopter
        tank += correction.tank
        apc += correction.apc
        fieldArtillery += correction.fieldArtillery
        mrl += correction.mrl
        militaryAuto += correction.militaryAuto
        fuelTank += correction.fuelTank
        drone += correction.drone
        navalShip += correction.navalShip
        antiAircraftWarfare += correction.antiAircraftWarfare
        specialEquipment += correction.specialEquipment
        greatestLossesDirection = correction.greatestLossesDirection
        vehiclesAndFuelTanks += correction.vehiclesAndFuelTanks
        mobileSRBMSystem += correction.mobileSRBMSystem
    }
}
