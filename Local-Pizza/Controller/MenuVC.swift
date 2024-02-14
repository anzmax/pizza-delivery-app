//
//  ViewController.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 12.02.2024.
//

import UIKit

enum MenuSection: Int, CaseIterable {
    case delivery = 0
    case stories = 1
    case specials = 2
    case categories = 3
    case products = 4
}

class MenuVC: UIViewController {

    var stories = [
        Story(image: "pizzaoffer"),
        Story(image: "nuggetsoffer"),
        Story(image: "drinksoffer"),
        Story(image: "dessertoffer"),
        Story(image: "combooffer"),
        Story(image: "colaoffer")
    ]

    var specials = [
        Special(title: "Пицца", price: "250 p", image: "roundpizza"),
        Special(title: "Донер", price: "117 p", image: "donerSpecial"),
        Special(title: "3 Соуса", price: "85 p", image: "sauceSpecial"),
        Special(title: "Трио", price: "789 p", image: "trioSpecial"),
        Special(title: "Десерт", price: "187 p", image: "sweetSpecial")
    ]
    
    var categories = [
        Category(title: "Завтрак"),
        Category(title: "Пиццы"),
        Category(title: "Закуски"),
        Category(title: "Напитки"),
        Category(title: "Десерты"),
        Category(title: "Соусы")
    ]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.layer.cornerRadius = 16
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DeliveryCell.self, forCellReuseIdentifier: DeliveryCell.id)
        tableView.register(StoriesTVCell.self, forCellReuseIdentifier: StoriesTVCell.id)
        tableView.register(SpecialsTVCell.self, forCellReuseIdentifier: SpecialsTVCell.id)
        tableView.register(CategoriesTVCell.self, forCellReuseIdentifier: CategoriesTVCell.id)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
}

//MARK: - Delagate
extension MenuVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        MenuSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sectionType = MenuSection(rawValue: section) {
            switch sectionType {
            case .delivery:
                return 1
            case .stories:
                return 1
            case .specials:
                return 1
            case .categories:
                return 1
            case .products:
                return 1
            }
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let sectionType = MenuSection(rawValue: indexPath.section) {
            switch sectionType {
            case .delivery:
                let cell = tableView.dequeueReusableCell(withIdentifier: DeliveryCell.id, for: indexPath) as! DeliveryCell
                return cell
            case .stories:
                let cell = tableView.dequeueReusableCell(withIdentifier: StoriesTVCell.id, for: indexPath) as! StoriesTVCell
                cell.update(with: stories)
                return cell
            case .specials:
                let cell = tableView.dequeueReusableCell(withIdentifier: SpecialsTVCell.id, for: indexPath) as! SpecialsTVCell
            
                cell.update(with: specials)
                return cell
            case .categories:
                let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesTVCell.id, for: indexPath) as! CategoriesTVCell
                cell.update(with: categories)
                return cell
            case .products:
                return UITableViewCell()
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let sectionType = MenuSection(rawValue: indexPath.section) {
            switch sectionType {
            case .stories:
                return 115
            case .specials:
                return 160
            case .categories:
                return 70
            default:
                return UITableView.automaticDimension
            }
        }
        return UITableView.automaticDimension
    }
}

//MARK: - Layout
extension MenuVC {
    func setupViews() {
        view.applyGradient(colors: [UIColor.lightGray.cgColor, UIColor.white.cgColor])
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}
