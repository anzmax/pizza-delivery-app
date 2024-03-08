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
        
        // Центральная точка коллекции относительно её текущего смещения
        let centerX = collectionView!.contentOffset.x + collectionView!.bounds.width / 2
        
        layoutAttributesArray?.forEach { attributes in
            // Расстояние ячейки от центра
            let distanceFromCenter = abs(attributes.center.x - centerX)
            
            // Преобразование расстояния в масштаб. Ближе к центру = больше масштаб.
            let scale = max(1 - (distanceFromCenter / collectionView!.bounds.width), 0.75) // 0.75 - минимальный масштаб
            
            // Применение масштаба к атрибутам
            attributes.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
        
        return layoutAttributesArray
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        // Всегда возвращаем true, чтобы атрибуты обновлялись при прокрутке
        return true
    }
}
