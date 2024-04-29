//
//  CenterZoomCollectionViewLayout.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 13.02.2024.
//

import UIKit

class CenterZoomCollectionViewLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributesArray = super.layoutAttributesForElements(in: rect)?.map { $0.copy() as! UICollectionViewLayoutAttributes }

        let centerX = collectionView!.contentOffset.x + collectionView!.bounds.width / 2
        
        layoutAttributesArray?.forEach { attributes in

            let distanceFromCenter = abs(attributes.center.x - centerX)
            
            let scale = max(1 - (distanceFromCenter / collectionView!.bounds.width), 0.75)
            attributes.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
        
        return layoutAttributesArray
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
