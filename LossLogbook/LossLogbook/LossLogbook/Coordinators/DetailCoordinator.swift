//
//  DetailCoordinator.swift
//  LossLogbook
//
//  Created by Illia Rahozin on 27.08.2023.
//

import UIKit


protocol DetailCoordinatorFlow {
    func dismiss()
}

class DetailCoordinator<T: Codable & TableRepresentable>: Coordinator {
    // MARK: - PROPERTIES
    var navigationController: UINavigationController
    var data: [T]
    
    init(navigationController: UINavigationController, data: [T]) {
        self.navigationController = navigationController
        self.data = data
    }
    
    init(navigationController: UINavigationController, data: T) {
        self.navigationController = navigationController
        self.data = [data]
    }

    func start() {
        let detailViewController = DetailViewController(data: data)
        detailViewController.coordinator = self
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
}

// MARK: - BaseCoordinatorFlow
extension DetailCoordinator: DetailCoordinatorFlow {
    func dismiss() {
        navigationController.popViewController(animated: true)
    }
    

}
