//
//  CustomLabel.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 29.04.2024.
//

import UIKit

class CustomLabel: UILabel {
    
    init(text: String, color: UIColor, size: CGFloat, fontWeight: UIFont.Weight) {
        super.init(frame: .zero)
        commonInit(text, color: color, size: size, fontWeight: fontWeight)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit(_ text: String, color: UIColor, size: CGFloat, fontWeight: UIFont.Weight) {
        self.text = text
        self.textColor = color
        self.font = UIFont.systemFont(ofSize: size, weight: fontWeight)
        self.numberOfLines = 0
    }
}

