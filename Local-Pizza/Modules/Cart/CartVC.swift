//
//  CartScreenVC.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 12.02.2024.
//

import UIKit

enum CartSectionType: Int, CaseIterable {
    case products
    case extras
    case promo
    case total
}

class CartVC: UIViewController {
    
    var itemsInCart: [Product] = [] {
        didSet {
            tableView.reloadData()
            calculateTotalAmountForProducts()
        }
    }
    let archiver = ProductsArchiver()
    
    var extras = [
        Extras(title: "Coca Cola", price: "128 р"),
        Extras(title: "Чизкейк", price: "238 р"),
        Extras(title: "Крылышки 12 шт", price: "312 р"),
    ]
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Корзина"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    lazy var paymentButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray6
        let totalAmount = calculateTotalAmountForProducts()
        button.setTitle("Оплатить на сумму \(totalAmount) рублей", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.layer.cornerRadius = 5
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        tableView.separatorStyle = .singleLine
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CartProductCell.self, forCellReuseIdentifier: CartProductCell.id)
        //tableView.register(CartExtrasCell.self, forCellReuseIdentifier: CartExtrasCell.id)
        tableView.register(ExtrasTVCell.self, forCellReuseIdentifier: ExtrasTVCell.id)
        tableView.register(PromoCodeCell.self, forCellReuseIdentifier: PromoCodeCell.id)
        tableView.register(CartExtrasCell.self, forCellReuseIdentifier: CartExtrasCell.id)
        tableView.register(TotalCell.self, forCellReuseIdentifier: TotalCell.id)
        return tableView
    }()
    
    lazy var pizzaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sadpizza")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Здесь пусто"
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    lazy var menuButton: UIButton = {
        let button = UIButton()
        button.setTitle("Перейти к меню", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        updateCartUI()
        //fetchProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchProducts()
    }
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(pizzaImageView)
        view.addSubview(descriptionLabel)
        view.addSubview(menuButton)
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(paymentButton)
    }

    func setupConstraints() {
        pizzaImageView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        paymentButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pizzaImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            pizzaImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pizzaImageView.widthAnchor.constraint(equalToConstant: 300),
            pizzaImageView.heightAnchor.constraint(equalToConstant: 300),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: pizzaImageView.bottomAnchor, constant: 16),
            
            menuButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            menuButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            menuButton.heightAnchor.constraint(equalToConstant: 50),
            menuButton.widthAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            paymentButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            paymentButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            paymentButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -110),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: paymentButton.topAnchor, constant: -20)
        ])
    }
    
    func updateCartUI() {
        
        if itemsInCart.isEmpty {
            pizzaImageView.isHidden = false
            descriptionLabel.isHidden = false
            menuButton.isHidden = false
            tableView.isHidden = true
            paymentButton.isHidden = true
        } else {
            pizzaImageView.isHidden = true
            descriptionLabel.isHidden = true
            menuButton.isHidden = true
            tableView.isHidden = false
            paymentButton.isHidden = false
        }
    }
    
    func calculateTotalAmountForProducts() -> Int {
        return itemsInCart.reduce(0) { sum, item in
            sum + (Int(item.price.replacingOccurrences(of: " р", with: "")) ?? 0)
        }
    }


    @objc func menuButtonTapped() {
        let menuVC = MenuVC()
        self.present(menuVC, animated: true)
    }
    
    func fetchProducts() {
        let products = archiver.fetch()
        self.itemsInCart = products
        updateCartUI()
        tableView.reloadData()
    }
}

extension CartVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return CartSectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let section = CartSectionType(rawValue: section) {
            switch section {
            case .products:
                return itemsInCart.count
            case .extras:
                //return extras.count
                return 1
            case .promo:
                return 1
            case .total:
                return 1
            }
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let section = CartSectionType(rawValue: indexPath.section) {
            switch section {
            case .products:
                let cell = tableView.dequeueReusableCell(withIdentifier: CartProductCell.id, for: indexPath) as! CartProductCell
                cell.selectionStyle = .none
                let product = itemsInCart[indexPath.row]
                cell.update(with: product)
                return cell
            case .extras:
                let cell = tableView.dequeueReusableCell(withIdentifier: ExtrasTVCell.id, for: indexPath) as! ExtrasTVCell
                let dessertsAndDrinks = itemsInCart.filter { product in
                    product.image.contains("dessert") || product.image.contains("drink")
                }
                cell.update(with: dessertsAndDrinks)
                cell.selectionStyle = .none
                return cell
            case .promo:
                let cell = tableView.dequeueReusableCell(withIdentifier: PromoCodeCell.id, for: indexPath) as! PromoCodeCell
                cell.selectionStyle = .none
                return cell
            case .total:
                let cell = tableView.dequeueReusableCell(withIdentifier: TotalCell.id, for: indexPath) as! TotalCell
                cell.selectionStyle = .none
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let section = CartSectionType(rawValue: section) {
            switch section {
            case .products:
                let headerView = UIView()
                headerView.backgroundColor = .white
                
                let titleLabel = UILabel()
                let totalAmount = calculateTotalAmountForProducts()
                titleLabel.text = "\(itemsInCart.count) товара на сумму \(totalAmount) рублей"
                titleLabel.textColor = .black
                titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
                
                headerView.addSubview(titleLabel)
                titleLabel.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
                    titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
                    titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10)
                ])
                
                return headerView
            case .extras:
                let headerView = UIView()
                headerView.backgroundColor = .white
                
                let titleLabel = UILabel()
                titleLabel.text = "Добавить"
                titleLabel.textColor = .black
                titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
                
                headerView.addSubview(titleLabel)
                titleLabel.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    titleLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
                    titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
                    titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10)
                ])
                return headerView
            case .promo:
                return nil
            case .total:
                return nil
            }
        }
        return nil
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let section = CartSectionType(rawValue: section) {
            switch section {
            case .products:
                return 40
            case .extras:
                return 40
            case .promo:
                return 0
            case .total:
                return 0
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let section = CartSectionType(rawValue: indexPath.section) {
            switch section {
            case .products:
                return 165
            case .extras:
                return 210
            case .promo:
                return 80
            case .total:
                return 100
            }
        }
        return 100
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete && indexPath.section == 0 {
            
            tableView.beginUpdates()
            
            let productToRemove = itemsInCart[indexPath.row]
            itemsInCart.remove(at: indexPath.row)
            archiver.remove(productToRemove)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.endUpdates()
            updateCartUI()
        }
    }
}
