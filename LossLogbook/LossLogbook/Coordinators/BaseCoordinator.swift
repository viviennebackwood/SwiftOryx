//
//  AppCoordinator.swift
//  LossLogbook
//
//  Created by Illia Rahozin on 23.08.2023.
//

import UIKit
import RxSwift

protocol BaseCoordinatorFlow {
    var disposeBag: DisposeBag { get }
    func showDetail(direction: HomeCollectionData) -> Observable<Void>
}

protocol SplashScreenCoordinatorDelegate: AnyObject {
    func splashScreenCoordinatorDidFinishAnimation()
}

class BaseCoordinator: Coordinator {
    // MARK: - PROPERTIES
    var navigationController: UINavigationController = UINavigationController()

    let disposeBag = DisposeBag()

    func start() -> Observable<Void> {
        return showSplashScreen()
    }

    func showSplashScreen() -> Observable<Void> {
        let splashScrennViewController = SplashScreenViewController()
        navigationController.viewControllers = [splashScrennViewController]

        return splashScrennViewController.rx_animationDidFinish
                    .take(1)
                    .map { [weak self] in
                        self?.showMainAppFlow()
                    }
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
    func showDetail(direction: HomeCollectionData) -> Observable<Void> {
        switch direction {
        case .Personnel:
            if let data = Model.shared.getPersonnelData(byDate: Model.shared.getSelectedDate()) {
                let detailCoordinator = DetailCoordinator<PersonnelJSON>(navigationController: navigationController, data: data)
                return detailCoordinator.start() // Return the observable from detailCoordinator.start()
            }
        case .EquipmentOryx:
            let data = Model.shared.getequipmentOryxData()
            let detailCoordinator = DetailCoordinator(navigationController: navigationController, data: data)
            return detailCoordinator.start() // Return the observable from detailCoordinator.start()
        case .Equimpent:
            if let data = Model.shared.getEquimpentData(byDate: Model.shared.getSelectedDate()) {
                let detailCoordinator = DetailCoordinator(navigationController: navigationController, data: data)
                return detailCoordinator.start() // Return the observable from detailCoordinator.start()
            }
        case .Donate:
            showDonate()
            return Observable.just(()) // Return a completed observable for the case of .Donate
        }
        return Observable.just(())
    }
}
