//
//  ViewController.swift
//  LossLogbook
//
//  Created by Illia Rahozin on 22.08.2023.
//

import UIKit

class HomeViewController: UICollectionViewController {
    
    // MARK: - PROPERTIES
    var coordinator: BaseCoordinatorFlow?
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Model.shared.getStartDate()
        datePicker.maximumDate = Model.shared.getLastDate()
        
        return datePicker
    }()
    
    // MARK: - INIT
    init() {
        super.init(collectionViewLayout: HomeCollectionLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        title = "🇺🇦 LogBook"
        
        view.preservesSuperviewLayoutMargins = true
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        let datePickerBarButtonItem = UIBarButtonItem(customView: datePicker)
        navigationItem.rightBarButtonItem = datePickerBarButtonItem
        
    }
    
    @objc private func datePickerValueChanged(_ sender: UIDatePicker) {
        Model.shared.setSelectedDate(with: sender.date)
    }

    
}


// MARK: - DATASOURCE/DELEGATE
extension HomeViewController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return HomeCollectionData.allCases.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as! HomeCollectionViewCell
        cell.configure(with: HomeCollectionData.allCases[indexPath.item])

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let direction = HomeCollectionData.allCases[indexPath.row]
        coordinator?.showDetail(direction: direction)
    }

}
