//
//  PopOverViewController.swift
//  LossLogbook
//
//  Created by Illia Rahozin on 28.08.2023.
//

import UIKit

class PopoverContentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var selectedEquipmentType: ((EquipmentUa?) -> Void)?
    
    var selectedIndexPath: IndexPath?
    
    let equipmentTypes: [EquipmentUa] = EquipmentUa.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        let tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return equipmentTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if selectedIndexPath == indexPath {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        cell.textLabel?.text = equipmentTypes[indexPath.row].rawValue
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let selectedType = equipmentTypes[indexPath.row]
        
        if selectedIndexPath == indexPath {
            selectedIndexPath = nil
        } else {
            selectedIndexPath = indexPath
        }
        
        selectedEquipmentType?(selectedType)
        dismiss(animated: true, completion: nil)
    }
}

