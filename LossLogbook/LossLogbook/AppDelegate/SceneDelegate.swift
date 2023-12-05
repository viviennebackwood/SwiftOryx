//
//  SceneDelegate.swift
//  LossLogbook
//
//  Created by Illia Rahozin on 22.08.2023.
//

import UIKit
import RxSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    var baseCoordinator: BaseCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window =  UIWindow(windowScene: windowScene)
        
        baseCoordinator = BaseCoordinator()
        baseCoordinator?.start()
                    .subscribe(onCompleted: { [weak self] in
                        // Handle completion, e.g., perform additional actions
                        print("Coordinator start completed.")
                    })
                    .disposed(by: baseCoordinator?.disposeBag ?? DisposeBag())
        
        window?.rootViewController = baseCoordinator?.navigationController
        window?.makeKeyAndVisible()
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }


}

