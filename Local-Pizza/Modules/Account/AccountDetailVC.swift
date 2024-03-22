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

class AccountDetailVC: UIViewController {
    
    var isExpanded = false
    let maxTableHeight: CGFloat = 175
    var tableViewHeightConstraint: NSLayoutConstraint!
    
    var connections: [Connection] = [
        Connection(title: "Написать на почту", image: UIImage(systemName: "envelope")),
        Connection(title: "Написать в телеграм", image: UIImage(systemName: "paperplane")),
        Connection(title: "Позвонить по телефону", image: UIImage(systemName: "phone"))
    ]
    
    var offers: [Offer] = [
        Offer(title: "Скидка 25% при заказе в пиццерии от 799 р", subtitle: "до 16 июня"),
        Offer(title: "Скидка 20% при заказе от 1049 р", subtitle: "до 16 августа"),
    ]
    
    var entertainments: [Entertainment] = [
        Entertainment(image: UIImage(named: "pizza-challenge")),
        Entertainment(image: UIImage(named: "homemadepizza")),
        Entertainment(image: UIImage(named: "pizzarecipe"))
    ]
    
    lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "gearshape"), for: .normal)
        button.tintColor = .black
        button.contentMode = .scaleToFill
        button.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var accountLabel: UILabel = {
        let label = UILabel()
        label.text = "Аккаунт"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    lazy var connectionTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
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
        view.backgroundColor = .white.withAlphaComponent(0.8)
        view.layer.cornerRadius = 12
        return view
    }()
    
    lazy var connectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Для связи с нами"
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        return label
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

    func setupViews() {
        view.applyGradient(colors: [UIColor.systemGray4.cgColor, UIColor.white.cgColor])
        
        [accountLabel, settingsButton, connectionTableView, headerView, accountTableView].forEach {
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
        
            settingsButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            settingsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            settingsButton.heightAnchor.constraint(equalToConstant: 50),
            settingsButton.widthAnchor.constraint(equalToConstant: 50),
            
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
            
            connectionTableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            connectionTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            connectionTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableViewHeightConstraint,
            
            connectionLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
            connectionLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            
            chevronButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            chevronButton.topAnchor.constraint(equalTo: connectionLabel.bottomAnchor, constant: 2)
        ])
    }
    
    @objc func settingsButtonTapped() {
        let vc = AccountSettingsVC()
        present(vc, animated: true)
    }
    
    @objc func toggleTableView() {
         tableViewHeightConstraint.constant = isExpanded ? 0 : maxTableHeight
         UIView.animate(withDuration: 0.3) {
             self.view.layoutIfNeeded()
         }
         isExpanded.toggle()
     }
}

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
                    return cell
                case .entertainment:
                    let cell = tableView.dequeueReusableCell(withIdentifier: EntertainmentTVCell.id, for: indexPath) as! EntertainmentTVCell
                    cell.update(with: entertainments)
                    
                    cell.onItemTapped = { [weak self] indexPath in
                        
                        var videoURL: URL?
                        
                        switch indexPath.row {
                        case 0:
                            videoURL = URL(string: "https://youtu.be/ggqXttEhWlY?si=HIfSQC5LWHk3umXI")
                        case 1:
                            videoURL = URL(string: "https://youtu.be/sv3TXMSv6Lw?si=Zlffeyae8OyM5WEi")
                        case 2:
                            videoURL = URL(string: "https://youtu.be/Eim2GpHNQDg?si=983bbagAMCTqbetP")
                        default:
                            videoURL = URL(string: "https://youtu.be/Eim2GpHNQDg?si=983bbagAMCTqbetP")
                        }
                        
                        let vc = EntertainmentVC(videoURL: videoURL)
                        self?.present(vc, animated: true)
                    }
                    
                    return cell
                }
            }
        }
        return UITableViewCell()
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.connectionTableView {
            if indexPath.row == 0 {
                let email = "pizzadelivery@test.com"
                if let url = URL(string: "mailto:\(email)"), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            } else if indexPath.row == 1 {
                let telegramUsername = "LilViolett"
                if let url = URL(string: "tg://resolve?domain=\(telegramUsername)"), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            } else if indexPath.row == 2 {
                let phoneNumber = "+447347737347"
                if let url = URL(string: "tel://\(phoneNumber)"), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
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
                headerLabel.text = "  Мои предложения"
            case .history:
                headerLabel.text = "  Последний заказ"
            case .entertainment:
                headerLabel.text = "  Время отдохнуть"
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
            return 30
        } else if tableView == self.connectionTableView {
            return 0
        }
        return 0
    }
}
