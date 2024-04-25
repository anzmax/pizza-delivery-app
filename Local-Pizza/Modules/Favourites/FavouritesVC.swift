//
//  ContactsSreenVC.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 12.02.2024.
//

import UIKit

protocol FavouritesVCProtocol: AnyObject {
    
    var presenter: FavouritesPresenterProtocol? { get set }
    
    //Update View
    func showFavouriteProducts(_ products: [Product])
    func updateFavouritesUI()
    func deleteFavouriteInTable(_ indexPath: IndexPath, _ product: Product)
}

class FavouritesVC: UIViewController, FavouritesVCProtocol {
   
    var presenter: FavouritesPresenterProtocol?
    
    var favouriteProducts = [Product]()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Избранное"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "Пока ничего не добавлено"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.id)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        NotificationCenter.default.addObserver(self, selector: #selector(updateFavorites), name: .favoritesDidUpdate, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter?.viewWillAppear()
    }

    @objc func updateFavorites() {
        
        self.presenter?.updateFavoritesInDataBase()
    }

    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

}

extension FavouritesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.id, for: indexPath) as! ProductCell
        let product = favouriteProducts[indexPath.row]
        cell.update(with: product)
        cell.favouriteButton.isHidden = true
        cell.selectionStyle = .none
        
        cell.onPriceButtonTapped = { product in
            //self.presenter?.cellPriceButtonTapped(product)
            self.cellPriceButtonTapped(product)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
           
           let deleteAction = UIContextualAction(style: .destructive, title: NSLocalizedString("Удалить", comment: "")) { [weak self] (action, view, completionHandler) in
               guard let self else { return }
               
               let productToDelete = favouriteProducts[indexPath.row]
               
               self.swipeToDeleteProduct(indexPath, productToDelete)
//               self.presenter?.productCellSwipeToDelete(indexPath, productToDelete)

               completionHandler(true)
           }
           
           let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
           configuration.performsFirstActionWithFullSwipe = true
           return configuration
       }
}

extension Notification.Name {
    static let favoritesDidUpdate = Notification.Name("favoritesDidUpdate")
}

//MARK: - Layout
extension FavouritesVC {
    func setupViews() {
        view.backgroundColor = .white
        [titleLabel, tableView, emptyLabel].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emptyLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80)
        ])
    }
}

//MARK: - Update View
extension FavouritesVC {
    
    func deleteFavouriteInTable(_ indexPath: IndexPath, _ product: Product) {
        
        self.favouriteProducts.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        self.updateFavouritesUI()
    }

    func showFavouriteProducts(_ products: [Product]) {
        self.favouriteProducts = products
        self.tableView.reloadData()
        self.updateFavouritesUI()
    }
    
    func updateFavouritesUI() {
        if favouriteProducts.isEmpty {
            tableView.isHidden = true
            emptyLabel.isHidden = false
        } else {
            tableView.isHidden = false
            emptyLabel.isHidden = true
        }
    }
}


//MARK: - Event Handler
extension FavouritesVC {
    
    func cellPriceButtonTapped(_ product: Product) {
        presenter?.cellPriceButtonTapped(product)
    }
    
    func swipeToDeleteProduct(_ indexPath: IndexPath, _ productToDelete: Product) {
        presenter?.productCellSwipeToDelete(indexPath, productToDelete)
    }
}
