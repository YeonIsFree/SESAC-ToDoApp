//
//  AddTodoViewController.swift
//  SESAC-ToDoApp
//
//  Created by Seryun Chun on 2024/02/14.
//

import UIKit

enum TableViewSection: Int, CaseIterable {
    case todo
    case deadLine
    case tag
    case priority
    case addImage
    
    var title: String {
        switch self {
        case .todo:
            return ""
        case .deadLine:
            return "마감일"
        case .tag:
            return "태그"
        case .priority:
            return "우선 순위"
        case .addImage:
            return "이미지 추가"
        }
    }
}

class AddTodoViewController: BaseViewController {
    
    var todoDate: String = ""
    var todoTag: String = ""
    var todoPriority: String = ""
    
    // MARK: - UI Property
    
    let addTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        return tableView
    }()
    
    // MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNotification()
        configureTableView()
        configureNavigationBar()
    }
    
     // MARK: - UI Configuration Method
    
    override func render() {
        view.addSubview(addTableView)
        addTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

 // MARK: - Notification Methods

extension AddTodoViewController {
    private func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(dateValueChanged), name: DateViewController.dateDidChanged, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(tagValueChanged), name: TagViewController.tagDidChanged, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(priorityValueChanged), name: PriorityViewController.priorityDidChanged, object: nil)
    }

    @objc func dateValueChanged(notification: NSNotification) {
        guard let value = notification.userInfo?["todoDate"] as? String else { return }
        todoDate = value
        addTableView.reloadData()
    }
    
    @objc func tagValueChanged(notification: NSNotification) {
        guard let value = notification.userInfo?["todoTag"] as? String else { return }
        todoTag = value
        addTableView.reloadData()
    }
    
    @objc func priorityValueChanged(notification: NSNotification) {
        guard let value = notification.userInfo?["todoPriority"] as? String else { return }
        todoPriority = value
        addTableView.reloadData()
    }
}


// MARK: - UITableView Delegate

extension AddTodoViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return TableViewSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddTableViewCell.identifier, for: indexPath) as? AddTableViewCell else { return UITableViewCell() }
            
            cell.selectionStyle = .none
            
            return cell
        }
        
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SubTableViewCell.identifier, for: indexPath) as? SubTableViewCell else { return UITableViewCell() }
            
            cell.configureCell(indexPath.section)
            
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .none
            
            switch indexPath.section {
            case 1:
                cell.cellSubTitleLabel.text = todoDate
            case 2:
                cell.cellSubTitleLabel.text = todoTag
            case 3:
                cell.cellSubTitleLabel.text = todoPriority
            case 4:
                cell.cellSubTitleLabel.text = ""
            default:
                break
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            let vc = DateViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = TagViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = PriorityViewController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 200
        default:
            return 60
        }
    }
}

// MARK: - UI Configuration Method

extension AddTodoViewController {
    private func configureTableView() {
        addTableView.delegate = self
        addTableView.dataSource = self
        addTableView.register(AddTableViewCell.self, forCellReuseIdentifier: AddTableViewCell.identifier)
        addTableView.register(SubTableViewCell.self, forCellReuseIdentifier: SubTableViewCell.identifier)
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "새로운 할 일"
        navigationController?.navigationBar.tintColor = .white
        
        let leftBarButton = UIBarButtonItem()
        leftBarButton.image = UIImage(systemName: "multiply")
        leftBarButton.action = #selector(cancelButtonTapped)
        leftBarButton.target = self
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
}
