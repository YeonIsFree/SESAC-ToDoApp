//
//  AddTodoViewController.swift
//  SESAC-ToDoApp
//
//  Created by Seryun Chun on 2024/02/14.
//

import UIKit
import RealmSwift
import Toast

enum TableViewSection: Int, CaseIterable {
    case todo
    case todoDate
    case todoTag
    case priority
    case addImage
    
    var title: String {
        switch self {
        case .todo:
            return ""
        case .todoDate:
            return "마감일"
        case .todoTag:
            return "태그"
        case .priority:
            return "우선 순위"
        case .addImage:
            return "이미지 추가"
        }
    }
    
    var viewController: PassDataDelegate? {
        switch self {
        case .todo:
            return nil
        case .todoDate:
            return DateViewController()
        case .todoTag:
            return TagViewController()
        case .priority:
            return PriorityViewController()
        case .addImage:
            return nil
        }
    }
}

class AddTodoViewController: BaseViewController {
    
    var todoTitle: String = ""
    var todoMemo: String = ""
    var changedValues: [String] = Array(repeating: "", count: TableViewSection.allCases.count)
    let repository = TodoTableRepository()
    
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
        changedValues[TableViewSection.todoDate.rawValue] = value
        addTableView.reloadData()
    }
    
    @objc func tagValueChanged(notification: NSNotification) {
        guard let value = notification.userInfo?["todoTag"] as? String else { return }
        changedValues[TableViewSection.todoTag.rawValue] = value
        addTableView.reloadData()
    }
    
    @objc func priorityValueChanged(notification: NSNotification) {
        guard let value = notification.userInfo?["todoPriority"] as? String else { return }
        changedValues[TableViewSection.priority.rawValue] = value
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
            
            // TextField Delegate
            cell.titleTextField.delegate = self
            cell.memoTextField.delegate = self
            
            // TextField에 tag 부여
            cell.titleTextField.tag = 100
            cell.memoTextField.tag = 101
            
            return cell
        }
        
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SubTableViewCell.identifier, for: indexPath) as? SubTableViewCell else { return UITableViewCell() }
            
            cell.configureCell(indexPath.section)
            
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .none
            
            let sectionType = TableViewSection.allCases[indexPath.section]
            cell.cellTitleLabel.text = sectionType.title
            cell.cellSubTitleLabel.text = changedValues[indexPath.section]
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sectionType = TableViewSection.allCases[indexPath.section]
        
        switch sectionType {
        case .todo:
            break
        default:
            if let vc = sectionType.viewController {
                vc.changedValue = { value in
                    self.changedValues[indexPath.section] = value
                    self.addTableView.reloadData()
                }
                navigationController?.pushViewController(vc, animated: true)
            }
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

// MARK: - TextField Delegate

extension AddTodoViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 100 {
            todoTitle = textField.text!
        } else {
            todoMemo = textField.text!
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
        
        let rightBarButton = UIBarButtonItem()
        rightBarButton.title = "추가"
        rightBarButton.action = #selector(addButtonTapped)
        rightBarButton.target = self
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func addButtonTapped() {
        // 제목 작성 됐는지 검사
        if todoTitle == "" {
            self.view.makeToast("제목을 입력해주세요", duration: 2.0, position: .top)
        } else {
            let todoData = TodoTable(todoTitle: todoTitle,
                                     todoMemo: todoMemo,
                                     date: changedValues[TableViewSection.todoDate.rawValue],
                                     tag: changedValues[TableViewSection.todoTag.rawValue],
                                     priority: changedValues[TableViewSection.priority.rawValue])
            
            repository.createTodo(todoData)
            
            // Home 화면 count 갱신을 위한 Noti post
            NotificationCenter.default.post(name: AddTodoViewController.allListDidChanged, object: nil)
            
            dismiss(animated: true)
        }
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
}

// MARK: - Notification

extension AddTodoViewController {
    static let allListDidChanged = Notification.Name("allListDidChanged")
}
