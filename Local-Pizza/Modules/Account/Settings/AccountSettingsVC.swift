//
//  AccountSettingsVC.swift
//  Local-Pizza
//
//  Created by Lika Maksimovic on 01.03.2024.
//

import UIKit

protocol AccountSettingsVCProtocol: AnyObject {
    
    //Connections
    var presenter: AccountSettingsPresenterProtocol? { get set }

    //Navigation
    func navigateToPreviousScreen()
    func navigateToAuthScreen()
}

class AccountSettingsVC: UIViewController, AccountSettingsVCProtocol {
    
    var presenter: AccountSettingsPresenterProtocol?
    
    //MARK: - UI Elements
    lazy var settingsLabel: UILabel = {
        let label = UILabel()
        label.text = "Настройки"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Готово", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.layer.cornerRadius = 16
        tableView.layer.masksToBounds = true
        
        tableView.separatorStyle = .singleLine
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PersonalCell.self, forCellReuseIdentifier: PersonalCell.id)
        tableView.register(NotificationsCell.self, forCellReuseIdentifier: NotificationsCell.id)
        tableView.register(LogoutCell.self, forCellReuseIdentifier: LogoutCell.id)
        tableView.register(DeleteCell.self, forCellReuseIdentifier: DeleteCell.id)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    //MARK: - Action
    @objc func doneButtonTapped() {
        var settings: [AccountSettingItem] = []
        
        for row in 0..<4 {
            let indexPath = IndexPath(row: row, section: 0)
            guard let cell = tableView.cellForRow(at: indexPath) as? PersonalCell,
                  let field = AccountField(rawValue: row),
                  let value = cell.infoTextField.text else { continue }
            
            let settingItem = AccountSettingItem(field: field, value: value)
            settings.append(settingItem)
        }
        
        presenter?.saveAccountSettings(with: settings)
    }
}

//MARK: - Delegate
extension AccountSettingsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 4
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return 1
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: PersonalCell.id, for: indexPath) as! PersonalCell
            
            let (field, value) = presenter?.fetchAccountField(indexPath.row) ?? (.name, "")
                   cell.update(field, value)
            
//            if let field = AccountField(rawValue: indexPath.row) {
//                let value = accountStorageservice.fetch(field: field)
//                
//                cell.update(field, value)
//            }

            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationsCell.id, for: indexPath) as! NotificationsCell
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: LogoutCell.id, for: indexPath) as! LogoutCell
            cell.selectionStyle = .none
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: DeleteCell.id, for: indexPath) as! DeleteCell
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
         return 14
     }
     
     func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
         let footerView = UIView()
         footerView.backgroundColor = .clear        
         return footerView
     }
     
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        presenter?.rowSelected(indexPath)
        tableView.reloadData()
    }
}

//MARK: - Layout
extension AccountSettingsVC {
    func setupViews() {
        view.applyGradient(colors: [UIColor.white.cgColor, UIColor.systemGray3.cgColor])
        [settingsLabel, doneButton, tableView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            settingsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            settingsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            doneButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor, constant: 24),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//MARK: - Navigation
extension AccountSettingsVC {
    func navigateToPreviousScreen() {
        self.dismiss(animated: true)
    }
    
    func navigateToAuthScreen() {
        let vc = AuthConfigurator().configure()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}
