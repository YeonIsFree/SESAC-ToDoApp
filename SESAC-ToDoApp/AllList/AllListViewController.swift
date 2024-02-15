//
//  ListViewController.swift
//  SESAC-ToDoApp
//
//  Created by Seryun Chun on 2024/02/15.
//

import UIKit
import RealmSwift

class AllListViewController: BaseViewController {
    
    var todoList: Results<TodoTable>! {
        didSet {
            listTableView.reloadData()
        }
    }
    
     // MARK: - UI Property
    
    let listTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        return tableView
    }()
    
    lazy var optionButtonItems: [UIAction] = {
        let orderByDate = UIAction(title: "마감일 순") { _ in
            self.getTodoList("date")
        }
        
        let orderByTitle = UIAction(title: "제목 순") { _ in
            self.getTodoList("todoTitle")
        }
        
        let items = [orderByDate, orderByTitle]
        return items
    }()

    


     // MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let realm = try! Realm()
        
        todoList = realm.objects(TodoTable.self)
    }
    
     // MARK: - UI Configuration Method
    
    override func render() {
        view.addSubview(listTableView)
        listTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureTableView() {
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(AllListTableViewCell.self, forCellReuseIdentifier: AllListTableViewCell.identifier)
    }
    
    private func configureNavigationBar() {
        let rightNavItem = UIBarButtonItem()
        rightNavItem.image = UIImage(systemName: "ellipsis.circle")
        rightNavItem.menu = UIMenu(title: "정렬", children: optionButtonItems)
        navigationItem.rightBarButtonItem = rightNavItem
    }
    
    @objc private func getTodoList(_ keyPath: String) {
        let realm = try! Realm()
        todoList = realm.objects(TodoTable.self).sorted(byKeyPath: keyPath)
    }
}

 // MARK: - UITableView Delegate

extension AllListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AllListTableViewCell.identifier, for: indexPath) as? AllListTableViewCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        
        cell.titleLabel.text = todoList[indexPath.row].todoTitle
        cell.titleLabel.font = .boldSystemFont(ofSize: 20)
        
        cell.subtitleLabel.text = todoList[indexPath.row].date
        cell.subtitleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
