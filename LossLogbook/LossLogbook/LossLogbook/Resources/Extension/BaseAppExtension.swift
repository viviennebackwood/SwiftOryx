//
//  Extension.swift
//  LossLogbook
//
//  Created by Illia Rahozin on 22.08.2023.
//

import UIKit

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func center(inView view: UIView, yConstant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yConstant!).isActive = true
    }
    
    func centerX(inView view: UIView, topAnchor: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if let topAnchor = topAnchor {
            self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop!).isActive = true
        }
    }
    
    func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil, paddingLeft: CGFloat? = nil, constant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant!).isActive = true
        
        if let leftAnchor = leftAnchor, let padding = paddingLeft {
            self.leftAnchor.constraint(equalTo: leftAnchor, constant: padding).isActive = true
        }
    }
    
    func setDimensions(width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func addConstraintsToFillView(_ view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        anchor(top: view.topAnchor, left: view.leftAnchor,
               bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    func fillSafeView(_ view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor,
               bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor)
    }
    
    func addSubviews(_ views: UIView...) {
       views.forEach { addSubview($0) }
    }
}

// MARK: - UIColor

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static let UA_FLAG_YELLOW = UIColor.rgb(red: 255, green: 221, blue: 0)
    static let UA_FLAG_BLUE   = UIColor.rgb(red: 0, green: 87, blue: 183)
    
    static let militaryColors = [
        UIColor.rgb(red: 77,  green: 120, blue: 78),
        UIColor.rgb(red: 110, green: 161, blue: 113),
        UIColor.rgb(red: 255, green: 215, blue: 152),
        UIColor.rgb(red: 103, green: 86,  blue: 69),
        UIColor.rgb(red: 66,  green: 71,  blue: 86)
    ]
    
    func getRandomMilitaryColors(count: Int) -> [UIColor] {
        guard count > 0 else {
            return [UIColor.rgb(red: 77,  green: 120, blue: 78), UIColor.rgb(red: 110, green: 161, blue: 113)]
        }
        
        let availableColors = UIColor.militaryColors
        let randomColors = (0..<count).map { _ in
            availableColors.randomElement() ?? UIColor.white
        }
        return randomColors
    }
}


extension UIView {
    func setGradientBackgroundColor(colorOne: UIColor, colorTow: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTow.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func createGradientBlur() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
        UIColor.white.withAlphaComponent(0).cgColor,
        UIColor.white.withAlphaComponent(1).cgColor]
        let viewEffect = UIBlurEffect(style: .light)
        let effectView = UIVisualEffectView(effect: viewEffect)
        effectView.frame = CGRect(x: self.bounds.origin.x, y: self.bounds.size.height, width: self.bounds.width, height: self.bounds.size.height)
        gradientLayer.frame = effectView.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0 , y: 0.3)
        effectView.autoresizingMask = [.flexibleHeight]
        effectView.layer.mask = gradientLayer
        effectView.isUserInteractionEnabled = false //Use this to pass touches under this blur effect
        addSubview(effectView)

    }
}


extension UIImageView {
    func applyBottomFadeEffect() {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [
            UIColor.black.cgColor,
            UIColor.clear.cgColor
        ]
        gradient.locations = [0, 0.85, 1]
        
        layer.mask = gradient
    }
}

