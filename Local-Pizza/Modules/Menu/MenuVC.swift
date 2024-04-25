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

protocol MenuVCProtocol: AnyObject {
    
    //Connections
    var presenter: MenuPresenterProtocol? { get set }
    
    //Update View
    func showProducts(_ products: [Product])
    func showSpecials(_ specials: [Special])
    func showCategories(_ categories: [Category])
    func showStories(_ stories: [Story])
    func scrollTableViewToIndexPath(_ indexPath: IndexPath, _ productIndex: Int)
    
    //Navigation
    func navigateToProductDetailScreen(_ product: Product)
    func navigateToAuthorizationScreen()
    func navigateToStoryDetailScreen(_ image: UIImage)
    func navigateToPizzaMapScreen()
    func navigateToDeliveryMapScreen()
}

class MenuVC: UIViewController, StoriesTVCellDelegate, MenuVCProtocol {
    
    var presenter: MenuPresenterProtocol?
    
    var addressText: String = "" {
        didSet {
            tableView.reloadData()
        }
    }
    
    var products: [Product] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var specials: [Special] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var stories: [Story] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var categories: [Category] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    //MARK: - UI Components
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.layer.cornerRadius = 16
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DeliveryCell.self, forCellReuseIdentifier: DeliveryCell.id)
        tableView.register(StoriesTVCell.self, forCellReuseIdentifier: StoriesTVCell.id)
        tableView.register(SpecialsTVCell.self, forCellReuseIdentifier: SpecialsTVCell.id)
        tableView.register(CategoriesTVCell.self, forCellReuseIdentifier: CategoriesTVCell.id)
        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.id)
        return tableView
    }()
    
    private lazy var accountButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "person.fill"), for: .normal)
        button.tintColor = .darkGray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(accountButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        
        presenter?.viewDidLoad()
    }
    
    func didSelectStoryImage(_ image: UIImage?) {
        
        presenter?.storyCellSelected(image)
    }
}

//MARK: - Event Pass
extension MenuVC {
    
    @objc func accountButtonTapped() {
        presenter?.accountButtonTapped()
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
                return products.count
            }
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let sectionType = MenuSection(rawValue: indexPath.section) {
            switch sectionType {
            case .delivery:
                let cell = tableView.dequeueReusableCell(withIdentifier: DeliveryCell.id, for: indexPath) as! DeliveryCell
                cell.selectionStyle = .none
                
                cell.update(addressText)
                
                cell.onAddressSegmentChanged = { deliveryType in
                    
                    self.addressTypeSegmentChanged(deliveryType)
                }
                
                cell.onAddressButtonTapped = {
                    self.addressButtonSelected()
                }
                
                return cell
            case .stories:
                let cell = tableView.dequeueReusableCell(withIdentifier: StoriesTVCell.id, for: indexPath) as! StoriesTVCell
                cell.selectionStyle = .none
                cell.update(with: stories)
                cell.delegate = self
                return cell
            case .specials:
                let cell = tableView.dequeueReusableCell(withIdentifier: SpecialsTVCell.id, for: indexPath) as! SpecialsTVCell
                cell.selectionStyle = .none
                cell.update(with: specials)
                return cell
            case .categories:
                let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesTVCell.id, for: indexPath) as! CategoriesTVCell
                cell.selectionStyle = .none
                cell.update(with: categories)
 
                cell.onCategorySelected = { index in
                    
                    self.categoryCellTapped(index)
                }
                
                return cell
            case .products:
                let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.id, for: indexPath) as! ProductCell
                let product = products[indexPath.row]
                cell.selectionStyle = .none
                cell.update(with: product)
                
                cell.onPriceButtonTapped = { product in
                    
                    self.productCellPriceButtonTapped(product)
                }
                
                cell.onFavouriteButtonTapped = { product in
                    
                    if let tabBarController = self.tabBarController,
                       let favouritesVC = tabBarController.viewControllers?[1] as? FavouritesVC {
                        
                        self.favouriteButtonSelected(favouritesVC, product)
                    }
                }
                
                return cell
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
            case .products:
                return UITableView.automaticDimension
            default:
                return UITableView.automaticDimension
            }
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let product = products[indexPath.row]
        productCellSelected(product)
    }
}

//MARK: - Update View
extension MenuVC {
    
    func scrollTableViewToIndexPath(_ indexPath: IndexPath, _ productIndex: Int) {
        if productIndex < self.tableView.numberOfRows(inSection: 4) {
            self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
    func showProducts(_ products: [Product]) {
        self.products = products
    }
    
    func showCategories(_ categories: [Category]) {
        self.categories = categories
    }
    
    func showSpecials(_ specials: [Special]) {
        self.specials = specials
    }
    
    func showStories(_ stories: [Story]) {
        self.stories = stories
    }
}

//MARK: - Event Handler
extension MenuVC {
    
    func favouriteButtonSelected(_ favouritesVC: FavouritesVC,  _ product: Product) {
        self.presenter?.favouriteButtonTapped(favouritesVC, product)
    }
    
    func categoryCellTapped(_ index: Int) {
        self.presenter?.categoryCellSelected(index, self.products)
    }
    
    func addressTypeSegmentChanged(_ deliveryType: DeliveryType) {
        self.presenter?.addressSegmentChanged(deliveryType)
    }
    
    func productCellPriceButtonTapped(_ product: Product) {
        self.presenter?.productPriceButtonTapped(product)
    }
    
    func productCellSelected(_ product: Product) {
        presenter?.productCellSelected(product)
    }
    
    func addressButtonSelected() {
        self.presenter?.addressButtonTapped()
    }
}

//MARK: - Navigation
extension MenuVC {
    
    func navigateToDeliveryMapScreen() {
        let deliveryMapVC = DeliveryMapConfigurator().configure()
        deliveryMapVC.onSaveAddress = { [weak self] address in
            self?.addressText = address
        }
        self.present(deliveryMapVC, animated: true)
    }
    
    func navigateToPizzaMapScreen() {
        let pizzaMapVC = PizzaMapConfigurator().configure() 
        pizzaMapVC.onAddressChanged = { addressText in
            self.addressText = addressText
        }
        self.present(pizzaMapVC, animated: true)
    }
    
    func navigateToProductDetailScreen(_ product: Product) {
        let vc = ProductDetailConfigurator().configure(product)
        present(vc, animated: true)
    }
    
    func navigateToAuthorizationScreen() {
        
        //let vc = AccountSettingsConfigurator().configure()
        
        let vc = AuthConfigurator().configure()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func navigateToStoryDetailScreen(_ image: UIImage) {
        let storyDetailVC = StoryDetailVC()
        storyDetailVC.image = image
        present(storyDetailVC, animated: true)
    }
    
    func navigateToDeliveryMap() {
        let deliveryMapVC = DeliveryMapVC()
        deliveryMapVC.onSaveAddress = { [weak self] address in
            self?.addressText = address
        }
        self.present(deliveryMapVC, animated: true)
    }
}

//MARK: - Layout
extension MenuVC {
    func setupViews() {
        view.applyGradient(colors: [UIColor.systemGray3.cgColor, UIColor.white.cgColor])
        [tableView, accountButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            accountButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            accountButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            accountButton.widthAnchor.constraint(equalToConstant: 70),
            accountButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
