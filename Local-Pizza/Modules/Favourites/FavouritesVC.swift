//
//  ContactsSreenVC.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 12.02.2024.
//

import UIKit

class FavouritesVC: UIViewController {
    
    var favouriteProducts = [Product]() 
    var archiver = ProductsArchiver()
    
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
        loadFavouritePosts()
        updateFavouritesUI()
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
    
    func loadFavouritePosts() {
        CoreDataService.shared.fetchFavouriteProducts { [weak self] products in
            DispatchQueue.main.async {
                self?.favouriteProducts = products
                self?.tableView.reloadData()
                self?.updateFavouritesUI()
            }
        }
    }

    @objc func updateFavorites() {
        CoreDataService.shared.fetchFavouriteProducts { [weak self] products in
            DispatchQueue.main.async {
                self?.favouriteProducts = products
                self?.tableView.reloadData()
            }
        }
    }

    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    
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
            self.archiver.append(product)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
           
           let deleteAction = UIContextualAction(style: .destructive, title: NSLocalizedString("Удалить", comment: "")) { [weak self] (action, view, completionHandler) in
               guard let self else { return }
               
               let productToDelete = favouriteProducts[indexPath.row]
               
               CoreDataService.shared.persistentContainer.performBackgroundTask { backgroundContext in
                   CoreDataService.shared.deleteFavouriteProduct(product: productToDelete, context: backgroundContext)
                   
                   DispatchQueue.main.async {
                       self.favouriteProducts.remove(at: indexPath.row)
                       tableView.deleteRows(at: [indexPath], with: .fade)
                       self.updateFavouritesUI()
                   }
               }
               
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
