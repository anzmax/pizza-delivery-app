//
//  DetailMenuVC.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 19.02.2024.
//

enum DetailSection: Int, CaseIterable {
    case image = 0
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
    
    var ingredients: [Ingredient] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    //MARK: - Services
    var archiver = ProductsArchiver()
    var ingredientsService = IngredientsNetworkService()
    
    private var basePrice: Int?
    private var isPizza: Bool = false
    
    //MARK: - UI Elements
    private lazy var cartButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray5
        button.setTitle("В корзину за \(product!.price)", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.layer.cornerRadius = 16
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
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
        fetchIngredients()
    }
    
    func setupViews() {
        view.backgroundColor = .white
        [tableView, cartButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: cartButton.topAnchor),
            
            cartButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 26),
            cartButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -26),
            cartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            cartButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    //MARK: - Update
    func update(with product: Product) {
        self.product = product
        self.basePrice = Int(product.price)
        updateCartButtonTitle()
        
        isPizza = product.image.lowercased().contains("pizza")
    }
    
    //MARK: - Fetch
    func fetchIngredients() {
        ingredientsService.fetchIngredients { result in
            switch result {
            case .success(let ingredients):
                self.ingredients = ingredients
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - Action
    @objc func cartButtonTapped(_ button: UIButton) {
        let originalColor = button.backgroundColor
        button.backgroundColor = .systemGray3

        UIView.animate(withDuration: 1, animations: {
            button.backgroundColor = originalColor
        })
        
        if let product = product {
            self.archiver.append(product)
        }
    }
    
    func updateCartButtonTitle(withAdditionalPrice additionalPrice: Int = 0) {
        guard let basePrice = basePrice else { return }
        let newPrice = basePrice + additionalPrice
        cartButton.setTitle("В корзину за \(newPrice) р", for: .normal)
    }
}

//MARK: - Delegate
extension ProductDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return isPizza ? DetailSection.allCases.count : 2
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
        
        if !isPizza && indexPath.section > 1 {
            return UITableViewCell()
        }
        
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
                let cell = tableView.dequeueReusableCell(withIdentifier: SizeCell.id, for: indexPath) as! SizeCell
                cell.selectionStyle = .none
                
                cell.onSizeChanged = { [weak self] selectedIndex in
                    let additionalPrice: Int
                    switch selectedIndex {
                    case 0: additionalPrice = 50
                    case 1: additionalPrice = 100
                    default: additionalPrice = 150
                    }
                    self?.updateCartButtonTitle(withAdditionalPrice: additionalPrice)
                }
                
                return cell
            case .dough:
                let cell = tableView.dequeueReusableCell(withIdentifier: DoughCell.id, for: indexPath) as! DoughCell
                return cell
            case .ingredients:
                let cell = tableView.dequeueReusableCell(withIdentifier: IngredientsTVCell.id, for: indexPath) as! IngredientsTVCell
                cell.selectionStyle = .none
                cell.update(with: ingredients)
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !isPizza && indexPath.section > 1 { return }
        
        if indexPath.section == 4 {
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.layer.borderColor = UIColor.red.cgColor
                cell.layer.borderWidth = 2
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if !isPizza && indexPath.section > 1 { return }
        
        if indexPath.section == 4 {
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.layer.borderColor = nil
                cell.layer.borderWidth = 0
            }
        }
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
                return 350
            }
        }
        return UITableView.automaticDimension
    }
}
