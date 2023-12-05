//
//  PersonnelJSON.swift
//  LossLogbook
//
//  Created by Illia Rahozin on 26.08.2023.
//

import Foundation

// MARK: - EquipmentElement
struct PersonnelJSON: Codable, TableRepresentable {
    
    var date: String
    var day, personnel: Int
    var equipmentPersonnel: EquipmentPersonnel
    var pow: Int?

    enum CodingKeys: String, CodingKey {
        case date, day, personnel
        case equipmentPersonnel = "personnel*"
        case pow = "POW"
    }
}

enum EquipmentPersonnel: String, Codable {
    case about = "about"
    case more = "more"
}

typealias Personel = [PersonnelJSON]
