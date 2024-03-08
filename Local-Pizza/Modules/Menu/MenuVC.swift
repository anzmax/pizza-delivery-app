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
    
    var archiver = ProductsArchiver()
    
    var addressText: String = "" {
        didSet {
            tableView.reloadData()
        }
    }

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
    
    var products = [
        Product(image: "sandwich1", title: "Сэндвич с ветчиной", description: "Ветчина, хлеб, сыр, майонез, салатные листья, момидор, огурец", price: "345 р"),
        Product(image: "sandwich4", title: "Донер", description: "Лепёшка, фалафель, салат, помидоры, огурцы, красный лук, капуста, соус тахини", price: "375 р"),
        Product(image: "br1", title: "Скрэмбл", description: "Яйца, молоко, соль, перец, масло, зелень, моцарелла", price: "375 р"),
        Product(image: "pizza1", title: "Пепперони", description: "Пикантная пепперони, увеличенная порция моцареллы, томаты, фирменный томатный соус", price: "от 625 р"),
        Product(image: "pizza2", title: "Итальянская", description: "Моцарелла, томаты, свежий базилик, оливковое масло, чеснок, перец чили (опционально), фирменный томатный соус", price: "456 р"),
        Product(image: "pizza3", title: "Грибы и колбаски", description: "Колбаски, грибы, моцарелла, томатный соус, оливковое масло, кинза", price: "512 р"),
        Product(image: "pizza4", title: "Вегетарианская", description: "Томаты, лук, перец, оливки, маслины, моцарелла, пармезан, томатный соус", price: "732 р"),
        Product(image: "pizza5", title: "Мясная", description: "Ветчина, пепперони, салями, бекон, шпинат, лук, моцарелла, сливочный или томатный соус", price: "756 р"),
        Product(image: "pizza6", title: "Маргарита", description: "Моцарелла, томаты, базилик, оливковое масло, фирменный томатный соус", price: "345 р"),
        Product(image: "pizza7", title: "Сырная", description: "Моцарелла, пармезан, гауда, чеддер, горгонзола, сливочный сыр, маслины, томатный соус", price: "415 р"),
        Product(image: "pizza8", title: "Маслины и грибы", description: "Шампиньоны, лисички, оливки, моцарелла, сливочный соус, чеснок, лук", price: "571 р"),
        Product(image: "pizza9", title: "Венецианская", description: "Перец, моцарелла, шампиньоны, куриная грудка, томаты, фирменный томатный соус, маслины", price: "645 р"),
        Product(image: "pizza10", title: "Греческая", description: "Фета, оливки, помидоры, лук, оливковое масло, томатный соус, орегано", price: "719 р"),
        Product(image: "snack1", title: "Картофель фри", description: "Запеченная картошечка с пряными специями", price: "270 р"),
        Product(image: "snack2", title: "Креветки в кляре", description: "Кляр изумительно хрустящий, креветки сочные и ароматные.", price: "420 р"),
        Product(image: "snack3", title: "Наггетсы", description: "Хрустящие кусочки куриного мяса, обжаренные до золотистой корочки", price: "382 р"),
        Product(image: "snack4", title: "Сырные палочки", description: "Нежный сыр моцарелла, обволакивающийся хрустящей корочкой", price: "234 р"),
        Product(image: "drink1", title: "Американо", description: "Классический напиток с простым, но насыщенным вкусом", price: "98 р"),
        Product(image: "drink2", title: "Горячий шоколад", description: "Согревающий в холодные дни и поднимающее настроение", price: "130 р"),
        Product(image: "drink3", title: "Каппучино", description: "Идеальное сочетание крепкого эспрессо и нежной молочной пенки", price: "250 р"),
        Product(image: "drink4", title: "Чай черный", description: "Насыщенный и ароматный напиток придающий энергию ", price: "99 р"),
        Product(image: "drink5", title: "Чай зеленый", description: "Освежающий напиток наполненный антиоксидантами", price: "99 р"),
        Product(image: "dessert1", title: "Пирог", description: "Изысканное сочетание нежного теста и аппетитной начинки", price: "от 180 р"),
        Product(image: "dessert2", title: "Баноффи", description: "Нежность бисквита, кремовая текстура карамели и ароматный вкус спелых бананов", price: "265 р"),
        Product(image: "dessert3", title: "Чизкейк", description: "Сливочный десерт с основой из крошечного теста, покрытый сочным фруктовым топпингом", price: "278 р"),
        Product(image: "dessert4", title: "Печенье", description: " Наслаждение в каждом кусочке", price: "189 р"),
        Product(image: "sauce1", title: "Томатный соус", description: "Насыщенный вкус и аромат, идеально подходящий к различным блюдам", price: "69 р"),
        Product(image: "sauce2", title: "Чесночный соус", description: "Интенсивный вкус с нотками ароматного чеснока", price: "69 р"),
        Product(image: "sauce3", title: "Горчичный соус", description: "Жгучий и ароматный, придающий остроты вашему блюду.", price: "69 р")
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
        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.id)
        return tableView
    }()
    
    private lazy var accountButton: UIButton = {
        let button = UIButton()
        //button.setTitle("Аккаунт", for: .normal)
        button.setImage(UIImage(systemName: "person.fill"), for: .normal)
        button.tintColor = .darkGray
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        button.backgroundColor = .systemGray6
        button.layer.cornerRadius = 8
        //button.backgroundColor = .white
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        accountButton.addTarget(self, action: #selector(accountButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - Action
    
    @objc func accountButtonTapped() {
        let vc = AccountVC()
        present(vc, animated: true)
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
                
                return cell
            case .stories:
                let cell = tableView.dequeueReusableCell(withIdentifier: StoriesTVCell.id, for: indexPath) as! StoriesTVCell
                cell.selectionStyle = .none
                cell.update(with: stories)
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
