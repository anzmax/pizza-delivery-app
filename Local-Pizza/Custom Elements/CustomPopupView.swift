//
//  CustomPopupView.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 01.05.2024.
//

import UIKit

class CustomPopupView: UIView {
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 15
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10
        
        let label = UILabel()
         label.numberOfLines = 0
         label.textAlignment = .center

        let attributedString = NSMutableAttributedString(string: "Спасибо!\n".localized(), attributes: [
             .font: UIFont.systemFont(ofSize: 24, weight: .bold)
         ])

        attributedString.append(NSAttributedString(string: "Оплата прошла успешно".localized(), attributes: [
             .font: UIFont.systemFont(ofSize: 18, weight: .regular)
         ]))
         
         label.attributedText = attributedString
         
         addSubview(label)
         label.translatesAutoresizingMaskIntoConstraints = false
         
         NSLayoutConstraint.activate([
             label.topAnchor.constraint(equalTo: topAnchor, constant: 20),
             label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
             label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
             label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
         ])
     }
    
    func show(in view: UIView) {
        view.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerYAnchor.constraint(equalTo: view.centerYAnchor),
            widthAnchor.constraint(equalToConstant: 350),
            heightAnchor.constraint(equalToConstant: 200)
        ])
        
        alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 4, animations: {
            self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
        }
    }
    
}
