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

class MenuVC: UIViewController, StoriesTVCellDelegate {

    //MARL: - Services
    var archiver = ProductsArchiver()
    var productsService = ProductNetworkService()
    var storiesService = StoriesNetworkService()
    var specialsService = SpecialsNetworkService()
    var categoriesService = CategoriesNetworkService()
    
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
        fetchProducts()
        fetchSpecials()
        fetchStories()
        fetchCategories()
    }
    
    //MARK: - Action
    @objc func accountButtonTapped() {
        let vc = AccountVC()
        present(vc, animated: true)
    }
    
    func didSelectStoryImage(_ image: UIImage?) {
        guard let image = image else { return }
        let storyDetailVC = StoryDetailVC()
        storyDetailVC.image = image
        present(storyDetailVC, animated: true)
    }
    
    //MARK: - Fetch Requests
    func fetchProducts() {
        productsService.fetchProducts { result in
            switch result {
            case .success(let products):
                self.products = products
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchSpecials() {
        specialsService.fetchSpecials { result in
            switch result {
            case .success(let specials):
                self.specials = specials
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchStories() {
        storiesService.fetchStory { result in
            switch result {
            case .success(let stories):
                self.stories = stories
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchCategories() {
        categoriesService.fetchCategory { result in
            switch result {
            case .success(let categories):
                self.categories = categories
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
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
                    
                    switch deliveryType {
                        
                    case .takeAway:
                        let pizzaMapVC = PizzaMapVC()
                        pizzaMapVC.onAddressChanged = { addressText in
                            
                        }
                        self.present(pizzaMapVC, animated: true)

                    case .address:
                        let deliveryMapVC = DeliveryMapVC()
                        deliveryMapVC.onSaveAddress = { [weak self] address in
                            self?.addressText = address
                        }
                        self.present(deliveryMapVC, animated: true)
                    }
                }
                
                cell.onAddressButtonTapped = {
                    let deliveryMapVC = DeliveryMapVC()
                    deliveryMapVC.onSaveAddress = { [weak self] address in
                        self?.addressText = address
                    }
                    self.present(deliveryMapVC, animated: true)
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
                return cell
            case .products:
                let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.id, for: indexPath) as! ProductCell
                let product = products[indexPath.row]
                cell.selectionStyle = .none
                cell.update(with: product)
                cell.onPriceButtonTapped = { product in
                    self.archiver.append(product)
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
        let vc = ProductDetailVC()
        vc.update(with: product)
        present(vc, animated: true)
    }
}

//MARK: - Layout
extension MenuVC {
    func setupViews() {
        view.applyGradient(colors: [UIColor.lightGray.cgColor, UIColor.white.cgColor])
        view.addSubview(tableView)
        view.addSubview(accountButton)
    }
    
    func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        accountButton.translatesAutoresizingMaskIntoConstraints = false
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
