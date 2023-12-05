//
//  DetailCoordinator.swift
//  LossLogbook
//
//  Created by Illia Rahozin on 27.08.2023.
//

import UIKit
import RxSwift

protocol DetailCoordinatorFlow {
    func dismiss() -> Observable<Void>
}

class DetailCoordinator<T: Codable & TableRepresentable>: Coordinator {
    // MARK: - PROPERTIES
    var navigationController: UINavigationController
    var data: [T]
    let disposeBag = DisposeBag()
    
    init(navigationController: UINavigationController, data: [T]) {
        self.navigationController = navigationController
        self.data = data
    }
    
    init(navigationController: UINavigationController, data: T) {
        self.navigationController = navigationController
        self.data = [data]
    }

    func start() -> Observable<Void> {
        let initialViewController = DetailViewController(data: data)
        initialViewController.coordinator = self
        navigationController.setViewControllers([initialViewController], animated: true)
        return Observable.just(())
    }
    
}

// MARK: - BaseCoordinatorFlow
extension DetailCoordinator: DetailCoordinatorFlow {
    func dismiss() -> Observable<Void> {
        return Observable.create { [weak self] observer in
            self?.navigationController.popViewController(animated: true)
            observer.onNext(()) // Emit completion signal when the detail view is popped
            return Disposables.create()
        }
    }
}
