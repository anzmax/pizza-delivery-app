//
//  UIViewColors.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 12.02.2024.
//

import UIKit

import UIKit

extension UIView {
    func applyGradient(colors: [CGColor], locations: [NSNumber]? = nil) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.locations = locations
        gradientLayer.frame = self.bounds

        // Настройка направления градиента
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0) // Верхний левый угол
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0) // Нижний правый угол

        // Удаление предыдущих градиентных слоев, если они есть
        self.layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }

        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

