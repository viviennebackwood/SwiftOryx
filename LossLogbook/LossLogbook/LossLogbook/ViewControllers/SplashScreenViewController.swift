//
//  SplashScreenViewController.swift
//  LossLogbook
//
//  Created by Illia Rahozin on 23.08.2023.
//

import UIKit

protocol SplashScreenViewControllerDelegate: AnyObject {
    func splashScreenAnimationDidFinish()
}

class SplashScreenViewController: UIViewController {
        
    private lazy var logoImageView: UIImageView = {
        let iv = UIImageView(image: Constant.Images.SplashScreenLogo)
        iv.contentMode = .scaleAspectFill
        
        return iv
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .blue
        indicator.startAnimating()
        
        return indicator
    }()
    
    weak var delegate: SplashScreenViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubviews(
            logoImageView,
            activityIndicator
        )
        logoImageView.center(inView: view)
        activityIndicator.anchor(
            top: logoImageView.bottomAnchor,
            paddingTop: 10
        )
        activityIndicator.centerX(inView: view)
        
        
        Model.shared.loadData { state in
            if state {
                DispatchQueue.main.async{ [weak self] in
                    self?.activityIndicator.stopAnimating()
                    self?.delegate?.splashScreenAnimationDidFinish()
                }
                
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.logoImageView.transform = .identity
        }
    }
    
}
