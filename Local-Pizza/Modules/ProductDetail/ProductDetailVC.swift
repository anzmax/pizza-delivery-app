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

protocol ProductDetailVCProtocol: AnyObject {
    
    var presenter: ProductDetailPresenterProtocol? { get set }
    
    func showIngredients(_ ingredients: [Ingredient])
    func showProductDough(_ index: Int)
    func showProductSize(_ index: Int)
    
    func navigateToPreviousScreen() 
}

final class ProductDetailVC: UIViewController, ProductDetailVCProtocol {
    
    var presenter: ProductDetailPresenterProtocol?
    
    private var product: Product? {
        didSet {
            tableView.reloadData()
            updateCartButtonTitle()
        }
    }
    
    var ingredients: [Ingredient] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    //MARK: - Services
    var archiver = ProductsArchiver()
    
    private var basePrice: Int?
    private var isPizza: Bool = false
    
    //MARK: - UI Elements
    private lazy var cartButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray5
        button.setTitle("В корзину за \(String(describing: product?.price)))", for: .normal)
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
        presenter?.viewDidLoad()
    }
    
    //MARK: - Action
    @objc func cartButtonTapped(_ button: UIButton) {
        presenter?.cartButtonTapped(cartButton, product)
    }
    
    func updateCartButtonTitle() {
        let totalPrice = product?.totalPrice() ?? 0
        let newPrice = "\(totalPrice)"
        
        convertAndLocalizePrice(rubles: newPrice, rate: 20) { localizedPrice in
            let buttonTitleFormat = NSLocalizedString("В корзину за %@", comment: "Add to cart button title format")
            let buttonTitle = String(format: buttonTitleFormat, localizedPrice)
            DispatchQueue.main.async {
                self.cartButton.setTitle(buttonTitle, for: .normal)
            }
        }
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
                
                cell.onSizeChanged = { sizeIndex in
                    guard let product = self.product else { return }
                    self.sizeCellSelected(sizeIndex, product)
                }
                
                return cell
            case .dough:
                let cell = tableView.dequeueReusableCell(withIdentifier: DoughCell.id, for: indexPath) as! DoughCell
                cell.selectionStyle = .none
                
                cell.onDoughChanged = { doughIndex in
                    guard let product = self.product else { return }
                    self.doughCellSelected(doughIndex, product)
                }
                
                return cell
            case .ingredients:
                let cell = tableView.dequeueReusableCell(withIdentifier: IngredientsTVCell.id, for: indexPath) as! IngredientsTVCell
                
                cell.onSelectIngredientCell = { changedIngredient in
                    
                    if self.product?.additions == nil {
                        self.product?.additions = [Ingredient]()
                    }
                    
                    let isSelected = changedIngredient.isSelected ?? false
                    
                    if isSelected == true {
                        self.product?.additions?.append(changedIngredient)
                    } else {
                        self.product?.additions?.removeAll(where: { $0.title == changedIngredient.title })
                    }
                    
                    if let index = self.ingredients.firstIndex(where: { $0.title == changedIngredient.title }) {
                        self.ingredients[index] = changedIngredient
                    }
                }
                
                cell.selectionStyle = .none
                cell.update(with: ingredients)
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
                return 350
            }
        }
        return UITableView.automaticDimension
    }
}

//MARK: - Event Handler
extension ProductDetailVC {
    
    func doughCellSelected(_ doughIndex: Int, _ product: Product) {
        presenter?.doughCellSelected(doughIndex, product)
    }
    
    
    func sizeCellSelected(_ sizeIndex: Int, _ product: Product) {
        presenter?.sizeCellSelected(sizeIndex, product)
    }
}

//MARK: - Update View
extension ProductDetailVC {
    
    func update(with product: Product) {
        self.product = product
        self.basePrice = Int(product.price)
        
        isPizza = product.image.lowercased().contains("pizza")
    }
    
    func showIngredients(_ ingredients: [Ingredient]) {
        self.ingredients = ingredients
    }
    
    func showProductDough(_ index: Int) {
        product?.dough = index
    }
    
    func showProductSize(_ index: Int) {
        product?.size = index
    }
}


//MARK: - Navigation
extension ProductDetailVC {
    
    func navigateToPreviousScreen() {
        self.dismiss(animated: true)
    }
}

//MARK: - Layout
extension ProductDetailVC {
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
}
