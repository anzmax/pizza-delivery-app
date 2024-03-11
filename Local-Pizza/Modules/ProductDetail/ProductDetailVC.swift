//
//  DetailMenuVC.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 19.02.2024.
//

enum DetailSection: Int, CaseIterable {
    case image
    case description
    case size
    case dough
    case ingredients
}

import UIKit

class ProductDetailVC: UIViewController {
    
    private var product: Product? {
        didSet {
            tableView.reloadData()
        }
    }
    
    private lazy var cartButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray5
        button.setTitle("В корзину за \(product!.price)", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 12
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.layer.cornerRadius = 16
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProductImageCell.self, forCellReuseIdentifier: ProductImageCell.id)
        tableView.register(DescriptionCell.self, forCellReuseIdentifier: DescriptionCell.id)
        tableView.register(SizeCell.self, forCellReuseIdentifier: SizeCell.id)
        tableView.register(DoughCell.self, forCellReuseIdentifier: DoughCell.id)
        tableView.register(IngredientsTVCell.self, forCellReuseIdentifier: IngredientsTVCell.id)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(cartButton)
    }
    
    func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        cartButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: cartButton.topAnchor, constant: -10),
            
            cartButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 26),
            cartButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -26),
            cartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            cartButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func update(with product: Product) {
        self.product = product
    }
}

extension ProductDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return DetailSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let section = DetailSection(rawValue: section) {
            switch section {
            case .image:
                return 1
            case .description:
                return 1
            case .size:
                return 1
            case .dough:
                return 1
            case .ingredients:
                return 1
            }
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let section = DetailSection(rawValue: indexPath.section) {
            switch section {
            case .image:
                let cell = tableView.dequeueReusableCell(withIdentifier: ProductImageCell.id, for: indexPath) as! ProductImageCell
                cell.selectionStyle = .none
                cell.update(with: product)
                return cell
            case .description:
                let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionCell.id, for: indexPath) as! DescriptionCell
                cell.selectionStyle = .none
                cell.update(with: product)
                return cell
            case .size:
                let cell = tableView.dequeueReusableCell(withIdentifier: SizeCell.id, for: indexPath)
                cell.selectionStyle = .none
                return cell
            case .dough:
                let cell = tableView.dequeueReusableCell(withIdentifier: DoughCell.id, for: indexPath)
                return cell
            case .ingredients:
                let cell = tableView.dequeueReusableCell(withIdentifier: IngredientsTVCell.id, for: indexPath)
                cell.selectionStyle = .none
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let section = DetailSection(rawValue: indexPath.section) {
            switch section {
            case .image:
                return UITableView.automaticDimension
            case .description:
                return UITableView.automaticDimension
            case .size:
                return UITableView.automaticDimension
            case .dough:
                return UITableView.automaticDimension

            case .ingredients:
                return UITableView.automaticDimension            }
        }
        return UITableView.automaticDimension
    }
}
