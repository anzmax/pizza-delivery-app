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
            paymentButton.setTitle("Оплатить на сумму \(calculateTotalAmountForProducts()) рублей", for: .normal)
        }
    }
    
    var dessertsAndDrinks: [Product] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    //MARK: - Services
    let archiver = ProductsArchiver()
    //let productService = ProductService()
    let extrasService = ExtrasNetworkService()
    
    //MARK: - UI Elements
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
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CartProductCell.self, forCellReuseIdentifier: CartProductCell.id)
        tableView.register(ExtrasTVCell.self, forCellReuseIdentifier: ExtrasTVCell.id)
        tableView.register(PromoCodeCell.self, forCellReuseIdentifier: PromoCodeCell.id)
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

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        updateCartUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchProducts()
        fetchDessertsAndDrinks()
    }
    
    //MARK: - Action
    func calculateTotalAmountForProducts() -> Int {
        var sum = 0
        for item in itemsInCart {
            let price = item.totalPrice()
            sum += price * item.count
        }
        return sum
    }

    @objc func menuButtonTapped() {
        self.tabBarController?.selectedIndex = 0
    }
    
    func fetchProducts() {
        let products = archiver.fetch()
        self.itemsInCart = products
        updateCartUI()
        tableView.reloadData()
    }
    
    func fetchDessertsAndDrinks() {
        //self.dessertsAndDrinks = productService.fetchDessertsAndDrinks()
        extrasService.fetchProducts { result in
            switch result {
            case .success(let products):
                self.dessertsAndDrinks = products
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//MARK: - Delegate
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
                
                
                cell.onProductCountChanged = { changedProduct in
                    
                    if let index = self.itemsInCart.firstIndex(where: { $0.title == changedProduct.title}) {
                        
                        if changedProduct.count == 0 {
                            self.itemsInCart.remove(at: index)
                        } else {
                            self.itemsInCart[index] = changedProduct
                        }
                        
                        self.archiver.save(self.itemsInCart)
                        self.fetchProducts()
                        tableView.reloadData()
                    }
                }
                
                cell.selectionStyle = .none
                let product = itemsInCart[indexPath.row]
                cell.update(with: product)
                return cell
            case .extras:
                let cell = tableView.dequeueReusableCell(withIdentifier: ExtrasTVCell.id, for: indexPath) as! ExtrasTVCell
                
                cell.onPriceButtonTapped = { product in
                    
                    self.archiver.append(product)
                    self.fetchProducts()
                    tableView.reloadData()
                }
                
                print(dessertsAndDrinks)
                cell.update(with: dessertsAndDrinks)
                cell.selectionStyle = .none
                return cell
            case .promo:
                let cell = tableView.dequeueReusableCell(withIdentifier: PromoCodeCell.id, for: indexPath) as! PromoCodeCell
                cell.selectionStyle = .none
                return cell
            case .total:
                let cell = tableView.dequeueReusableCell(withIdentifier: TotalCell.id, for: indexPath) as! TotalCell
                cell.update(items: itemsInCart)
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: NSLocalizedString("Удалить", comment: "")) { [weak self] action, view, completionHandler in
            guard let self = self else { return }

            tableView.beginUpdates()
        
            let productToRemove = itemsInCart[indexPath.row]
            itemsInCart.remove(at: indexPath.row)
            self.archiver.remove(productToRemove)

            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.endUpdates()
            updateCartUI()
            completionHandler(true)
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }

}

//MARK: Layout
extension CartVC {
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
    
    func setupViews() {
        view.backgroundColor = .white
        [pizzaImageView, descriptionLabel, menuButton, titleLabel, tableView, paymentButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    func setupConstraints() {
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
}
