//
//  Coordinator.swift
//  LossLogbook
//
//  Created by Illia Rahozin on 23.08.2023.
//

import UIKit
import RxSwift

protocol Coordinator {
    var navigationController: UINavigationController { get }
    
    func start() -> Observable<Void>
}
