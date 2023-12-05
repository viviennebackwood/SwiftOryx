//
//  Model.swift
//  LossLogbook
//
//  Created by Illia Rahozin on 27.08.2023.
//

import Foundation

class Model {
    static let shared = Model()
    
    private var selectedDate: Date? 
    private var startDate: Date?
    private var lastDate: Date?
    
    
    private var personnelData: [PersonnelJSON] = []
    private var equipmentOryxData: [EquipmentOryxJSON] = []
    private var equimpentData: [EquipmentJSON] = []
    
    func setData<T: Codable>(storage: HomeCollectionData, data: T) {
        switch storage {
        case .Personnel:
            if let data = data as? [PersonnelJSON] {
                personnelData = data
            }
        case .EquipmentOryx:
            if let data = data as? [EquipmentOryxJSON] {
                equipmentOryxData = data
            }
        case .Equimpent:
            if let data = data as? [EquipmentJSON] {
                equimpentData = data
            }
        case .Donate:
            break
        }
    }
    
    func setSelectedDate(with date: Date) {
        selectedDate = date
    }
    
    func getSelectedDate() -> Date? {
        return selectedDate
    }
    
    func getStartDate() -> Date? {
        return startDate
    }
    
    func getLastDate() -> Date? {
        return lastDate
    }
    
    func getPersonnelData(byDate date: Date?) -> PersonnelJSON? {
        return personnelData.first { $0.date == date?.toString() }
    }
    
    func getequipmentOryxData() -> [EquipmentOryxJSON] {
        return equipmentOryxData
    }
    
    func getEquimpentData(byDate date: Date?) -> EquipmentJSON? {
        return equimpentData.first { $0.date == date?.toString() }
    }
    
    func loadData(completion: @escaping (Bool) -> Void) {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        NetworkManager().fetchEquiment { [weak self] result in
            switch result {
            case .success(let success):
                self?.equimpentData = success
                dispatchGroup.leave()
            case .failure(let failure):
                print(failure.description)
            }
        }

        dispatchGroup.enter()
        NetworkManager().fetchEquimentOryx { [weak self] result in
            switch result {
            case .success(let success):
                self?.equipmentOryxData = success
                dispatchGroup.leave()
            case .failure(let failure):
                print(failure.description)
            }
        }

        dispatchGroup.enter()
        NetworkManager().fetchPersonnel { [weak self] result in
            switch result {
            case .success(let success):
                self?.personnelData = success
                dispatchGroup.leave()
            case .failure(let failure):
                print(failure.description)
            }

        }

        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.setDateLimits()
            completion(true)
        }
    }
}


extension Model {
    private func setDateLimits() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let firstData = personnelData.first
        let lastData  = personnelData.last
        
        if let startStr = firstData?.date, let endStr = lastData?.date {
            let startDate = dateFormatter.date(from: startStr)
            let endDate   = dateFormatter.date(from: endStr)
        
            self.startDate = startDate
            self.lastDate  = endDate
            self.selectedDate = endDate
            
        }
    }
}
