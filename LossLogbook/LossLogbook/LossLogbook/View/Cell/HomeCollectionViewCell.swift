//
//  HomeCollectionViewCell.swift
//  LossLogbook
//
//  Created by Illia Rahozin on 27.08.2023.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "HomeCollectionViewCell"
    
    // MARK: - PROPERTIES
    private lazy var imageView: UIImageView = {
        let iv = UIImageView(image: Constant.Images.Personel)
        iv.contentMode = .scaleAspectFit
        
        return iv
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Personnel"
        label.font = .systemFont(ofSize: 34, weight: .black)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        
        return label
    }()
    
    // MARK: - LIFECYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemGray5
        contentView.layer.cornerRadius = 10
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - CONFIGURE
    func configure(with data: HomeCollectionData) {
        imageView.image = data.image
        titleLabel.text = data.title
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setLayout()
    }
    
    
}

// MARK: - LAYOUT
extension HomeCollectionViewCell {
    
    private func setLayout() {
    
        imageView.addConstraintsToFillView(self)
        
        titleLabel.anchor(
            left: imageView.leftAnchor,
            bottom: contentView.bottomAnchor,
            right: imageView.rightAnchor,
            paddingTop: 10,
            paddingLeft: 5,
            paddingBottom: 5,
            paddingRight: 5
        )
    }
    
    func setupCell() {
        
        roundCorner()
        gradientBackgroundColor()
        setCellShadow()
        
        contentView.addSubviews(
            imageView,
            titleLabel
        )
        
    }
    
    private func setCellShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 3.0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 3
        self.clipsToBounds = false
    }
    
    private func cellRandomBackgroundColors() -> [UIColor] {
        return UIColor().getRandomMilitaryColors(count: 0)
    }
    
    private func gradientBackgroundColor() {
        let colors = cellRandomBackgroundColors()
        self.contentView.setGradientBackgroundColor(colorOne: colors[0], colorTow: colors[1])
    }
    
    private func roundCorner() {
        self.contentView.layer.cornerRadius = 12.0
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
    }

}
