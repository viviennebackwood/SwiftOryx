//
//  AppCoordinator.swift
//  LossLogbook
//
//  Created by Illia Rahozin on 23.08.2023.
//

import UIKit

protocol BaseCoordinatorFlow {
    func showDetail(direction: HomeCollectionData)
}

protocol SplashScreenCoordinatorDelegate: AnyObject {
    func splashScreenCoordinatorDidFinishAnimation()
}

class BaseCoordinator: Coordinator {
    // MARK: - PROPERTIES
    var navigationController: UINavigationController = UINavigationController()

    func start() {
        showSplashScreen()
    }
    
    // MARK: - COORDINATION
    func showSplashScreen() {
        let splashScrennViewController = SplashScreenViewController()
        splashScrennViewController.delegate = self
        navigationController.viewControllers = [splashScrennViewController]
    }

    private func showMainAppFlow() {
        let initialViewController = HomeViewController()
        initialViewController.coordinator = self
        navigationController.setViewControllers([initialViewController], animated: true)
    }
    
    private func showDonate() {
        if let url = URL(string: "https://savelife.in.ua/donate/") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                print("Cannot open URL")
            }
        }
    }
}

// MARK: - SplashPresenterDelegate
extension BaseCoordinator: SplashScreenViewControllerDelegate {
    func splashScreenAnimationDidFinish() {
        showMainAppFlow()
    }
}

// MARK: - BaseCoordinatorFlow
extension BaseCoordinator: BaseCoordinatorFlow {
    func showDetail(direction: HomeCollectionData) {
        switch direction {
        case .Personnel:
            if let data = Model.shared.getPersonnelData(byDate: Model.shared.getSelectedDate()) {
                let detailCoordinator = DetailCoordinator<PersonnelJSON>(navigationController: navigationController, data: data)
                detailCoordinator.start()
            }
        case .EquipmentOryx:
            let data = Model.shared.getequipmentOryxData()
            let detailCoordinator = DetailCoordinator(navigationController: navigationController, data: data)
            detailCoordinator.start()
        case .Equimpent:
            if let data = Model.shared.getEquimpentData(byDate: Model.shared.getSelectedDate()) {
                let detailCoordinator = DetailCoordinator(navigationController: navigationController, data: data)
                detailCoordinator.start()
            }
        case .Donate:
            showDonate()
        }
    }
}
