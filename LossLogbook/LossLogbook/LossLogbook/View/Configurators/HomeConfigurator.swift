//
//  HomeConfig.swift
//  LossLogbook
//
//  Created by Illia Rahozin on 27.08.2023.
//

import UIKit


// MARK: - HomeCollectionData
enum HomeCollectionData: CaseIterable {
    case Personnel
    case EquipmentOryx
    case Equimpent
    case Donate
    
    var title: String {
        switch self {
        case .Personnel:
            return "Personnel"
        case .EquipmentOryx:
            return "Equipment Oryx"
        case .Equimpent:
            return "Equipment"
        case .Donate:
            return "Donate"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .Personnel:
            return Constant.Images.Personel
        case .EquipmentOryx:
            return Constant.Images.VehiclesDestroyed
        case .Equimpent:
            return Constant.Images.VehiclesDestroyed
        case .Donate:
            return Constant.Images.Donate
        }
    }
}


// MARK: - HomeCollectionLayout
class HomeCollectionLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        scrollDirection = .horizontal
        itemSize = . init(width: 280, height: 400)
        sectionInsetReference = .fromLayoutMargins
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        guard let collectionView = self.collectionView else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }
        
        let horizontalOffest = proposedContentOffset.x
        let targetRect = CGRect.init(
            origin: .init(
                        x: proposedContentOffset.x,
                        y: 0
                    ),
            size: collectionView.bounds.size)
        
        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        
        for layoutAttributes in super.layoutAttributesForElements(in: targetRect)! {
            let itemOffset = layoutAttributes.frame.origin.x
            
            if (abs(itemOffset - horizontalOffest) < abs(offsetAdjustment)) {
                offsetAdjustment = itemOffset - horizontalOffest
            }
        }
        
        return CGPoint.init(
                    x: proposedContentOffset.x + offsetAdjustment - collectionView.layoutMargins.left,
                    y: 0
                )
    }
}
