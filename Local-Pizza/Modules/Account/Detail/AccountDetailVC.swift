//
//  AccountDetailVC.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 19.02.2024.
//

import UIKit

enum AccountSectionType: Int, CaseIterable {
    case offers
    case history
    case entertainment
}

protocol AccountDetailVCProtocol: AnyObject {
    
    var presenter: AccountDetailPresenterProtocol? { get set }
    
    func tableViewHeightChanged()
    
    func navigateToSettingsScreen()
    func navigateToMenuScreen()
    func navigateToEntertainmentScreen(withURL url: URL)
    func navigateToEmailScreen()
    func navigateToTelegramScreen()
    func navigateToPhoneCallScreen()
}

final class AccountDetailVC: UIViewController, AccountDetailVCProtocol {
    
    var presenter: AccountDetailPresenterProtocol?
    
    var isExpanded = false
    let maxTableHeight: CGFloat = 140
    var tableViewHeightConstraint: NSLayoutConstraint!
    
    var connections: [Connection] = [
        Connection(title: "Написать на почту".localized(), image: UIImage(systemName: "envelope")),
        Connection(title: "Написать в телеграм".localized(), image: UIImage(systemName: "paperplane")),
        Connection(title: "Позвонить по телефону".localized(), image: UIImage(systemName: "phone"))
    ]
    
    var offers: [Offer] = [
        Offer(title: "Скидка 25% в пиццерии от 799 р".localized(), subtitle: "до 16 июня".localized()),
        Offer(title: "Скидка 20% при заказе от 1049 р".localized(), subtitle: "до 16 августа".localized()),
    ]
    
    var entertainments: [Entertainment] = [
        Entertainment(image: UIImage(named: "pizza-challenge")),
        Entertainment(image: UIImage(named: "homemadepizza")),
        Entertainment(image: UIImage(named: "pizzarecipe"))
    ]
    
    //MARK: - UI Elements
    
    lazy var accountLabel = CustomLabel(text: "Аккаунт".localized(), color: .black, size: 24, fontWeight: .bold)
    
    lazy var connectionLabel = CustomLabel(text: "Для связи с нами".localized(), color: .black, size: 17, fontWeight: .medium)
    
    lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "gearshape"), for: .normal)
        button.tintColor = .black.withAlphaComponent(0.7)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.seal"), for: .normal)
        button.tintColor = .black.withAlphaComponent(0.7)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var connectionTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white.withAlphaComponent(0.8)
        tableView.contentInset = .zero
        tableView.showsVerticalScrollIndicator = false
        tableView.layer.cornerRadius = 12
        tableView.separatorStyle = .singleLine
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ConnectionCell.self, forCellReuseIdentifier: ConnectionCell.id)
        return tableView
    }()
    
    lazy var accountTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 12
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OffersTVCell.self, forCellReuseIdentifier: OffersTVCell.id)
        tableView.register(EntertainmentTVCell.self, forCellReuseIdentifier: EntertainmentTVCell.id)
        tableView.register(HistoryCell.self, forCellReuseIdentifier: HistoryCell.id)
        return tableView
    }()
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.7)
        view.applyShadow(color: .systemGray2)
        view.layer.cornerRadius = 12
        return view
    }()
    
    lazy var chevronButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = .gray
        button.addTarget(self, action: #selector(toggleTableView), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    //MARK: - Action
    @objc func settingsButtonTapped() {
        presenter?.settingsButtonTapped()
    }
    
    @objc func closeButtonTapped() {
        presenter?.closeButtonTapped()
    }
    
    @objc func toggleTableView() {
        presenter?.chevronButtonTapped()
    }
}

//MARK: - Delegate
extension AccountDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == self.accountTableView {
            return AccountSectionType.allCases.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.connectionTableView {
            return 3
        } else if tableView == self.accountTableView {
            return 1
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.connectionTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: ConnectionCell.id, for: indexPath) as! ConnectionCell
            let connection = connections[indexPath.row]
            cell.update(with: connection)
            return cell
            
        } else if tableView == self.accountTableView {
            if let sectionType = AccountSectionType(rawValue: indexPath.section) {
                switch sectionType {
                case .offers:
                    let cell = tableView.dequeueReusableCell(withIdentifier: OffersTVCell.id, for: indexPath) as! OffersTVCell
                    cell.update(with: offers)
                    return cell
                case .history:
                    let cell = tableView.dequeueReusableCell(withIdentifier: HistoryCell.id, for: indexPath) as! HistoryCell
                    cell.selectionStyle = .none
                    return cell
                case .entertainment:
                    let cell = tableView.dequeueReusableCell(withIdentifier: EntertainmentTVCell.id, for: indexPath) as! EntertainmentTVCell
                    cell.update(with: entertainments)
                    
                    cell.onItemTapped = { [weak self] indexPath in
                        
                        self?.entertainmentCellTapped(indexPath)
                    }
                    return cell
                }
            }
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.connectionTableView {
            self.collectionItemSelected(indexPath)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == self.accountTableView {
            let headerLabel = UILabel()
            headerLabel.backgroundColor = .clear
            headerLabel.textColor = .black
            headerLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
            
            switch AccountSectionType(rawValue: section) {
            case .offers:
                headerLabel.text = "  Мои предложения".localized()
            case .history:
                headerLabel.text = "  Последний заказ".localized()
            case .entertainment:
                headerLabel.text = "  Время отдохнуть".localized()
            default:
                headerLabel.text = "  "
            }
            return headerLabel
            
        } else if tableView == self.connectionTableView {
            return UIView()
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == self.accountTableView {
            return 32
        } else if tableView == self.connectionTableView {
            return 0
        }
        return 0
    }
}

//MARK: - Layout
extension AccountDetailVC {
    
    func setupViews() {
        
        view.applyGradient(colors: [UIColor.white.cgColor, UIColor.systemGray3.cgColor])
        
        [accountLabel, settingsButton, connectionTableView, headerView, accountTableView, closeButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [connectionLabel, chevronButton].forEach {
            headerView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupConstraints() {
        tableViewHeightConstraint = connectionTableView.heightAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            settingsButton.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: -16),
            
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            accountLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            accountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            accountTableView.topAnchor.constraint(equalTo: accountLabel.bottomAnchor, constant: 10),
            accountTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            accountTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            accountTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -250),
            
            headerView.topAnchor.constraint(equalTo: accountTableView.bottomAnchor, constant: 10),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            headerView.heightAnchor.constraint(equalToConstant: 55),
            
            connectionTableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10),
            connectionTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            connectionTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableViewHeightConstraint,
            
            connectionLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
            connectionLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            
            chevronButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            chevronButton.topAnchor.constraint(equalTo: connectionLabel.bottomAnchor, constant: 2)
        ])
    }
    
}

//MARK: - Event handler
extension AccountDetailVC {
    
    func entertainmentCellTapped(_ indexPath: IndexPath) {
        presenter?.entertainmentItemTapped(indexPath)
    }
    
    func collectionItemSelected(_ indexPath: IndexPath) {
        presenter?.didSelectConnectionItem(indexPath.row)
    }
}

//MARK: - Update View
extension AccountDetailVC {
    
    func tableViewHeightChanged() {
        tableViewHeightConstraint.constant = isExpanded ? 0 : maxTableHeight
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        isExpanded.toggle()
    }
}

//MARK: - Navigation
extension AccountDetailVC {
    func navigateToSettingsScreen() {
        let vc = AccountSettingsConfigurator().configure()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func navigateToMenuScreen() {
        let tabBarVC = MainTabVC()
        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: true)
    }
    
    func navigateToEntertainmentScreen(withURL url: URL) {
        let vc = EntertainmentVC(videoURL: url)
        present(vc, animated: true)
    }
    
    func navigateToEmailScreen() {
        let email = "pizzadelivery@test.com"
        if let url = URL(string: "mailto:\(email)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func navigateToTelegramScreen() {
        let telegramUsername = "anzmax"
        if let url = URL(string: "tg://resolve?domain=\(telegramUsername)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func navigateToPhoneCallScreen() {
        let phoneNumber = "+447347737347"
        if let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
