//
//  Endpoint.swift
//  LossLogbook
//
//  Created by Illia Rahozin on 25.08.2023.
//

import Foundation

// MARK: - Endoint

struct Endpoint {
    let path: String
    let baseURL: String
    
    var url: URL? {
        return URL(string: baseURL + path)
    }
    
    // Default endpoints enum
    enum DefaultEndpoint {
        case equipment
        case equipment_correction
        case equipment_oryx
        case personnel
        
        var path: String {
            switch self {
            case .equipment:
                return "/russia_losses_equipment.json"
            case .equipment_correction:
                return "/russia_losses_equipment_correction.json"
            case .equipment_oryx:
                return "/russia_losses_equipment_oryx.json"
            case .personnel:
                return "/russia_losses_personnel.json"
            }
        }
        
        var baseURL: String {
            return "https://raw.githubusercontent.com/MacPaw/2022-Ukraine-Russia-War-Dataset/main/data"
        }
        
        var endpoint: Endpoint {
            return Endpoint(path: path, baseURL: baseURL)
        }
    }

}
