//
//  OryxTableViewCell.swift
//  LossLogbook
//
//  Created by Illia Rahozin on 27.08.2023.
//

import UIKit

class OryxTableViewCell: UITableViewCell {
    
    static let identifier = "OryxTableViewCell"
    
    lazy var weaponImageView: UIImageView = {
        let iv = UIImageView(image: Constant.Images.SplashScreenLogo)
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 15.0
        contentView.clipsToBounds = true
        
        contentView.addSubviews(
            weaponImageView,
            descriptionLabel
        )
        setLayout()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10))
        weaponImageView.applyBottomFadeEffect()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(img: UIImage?, info: String) {
        weaponImageView.image = img
        descriptionLabel.text = info
        //weaponImageView.applyBottomFadeEffect()
    }
    
    private func setLayout() {
        contentView.addSubviews(
            weaponImageView,
            descriptionLabel
        )
        
        weaponImageView.anchor(
            top:     contentView.topAnchor,
            left:    contentView.leftAnchor,
            bottom:  contentView.bottomAnchor,
            right:   contentView.rightAnchor
        )
        
        descriptionLabel.anchor(
            left:    contentView.leftAnchor,
            bottom:  contentView.bottomAnchor,
            right:   contentView.rightAnchor,
            paddingLeft: 10,
            paddingBottom: 10,
            paddingRight: 10
        )
        
    }
    
}
