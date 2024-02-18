//
//  ListViewController.swift
//  SESAC-ToDoApp
//
//  Created by Seryun Chun on 2024/02/15.
//

import UIKit
import RealmSwift

class AllListViewController: BaseViewController {
    
    let repository = TodoTableRepository()
    
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
            self.todoList = self.repository.fetchSortedTodoList("date")
        }
        
        let orderByTitle = UIAction(title: "제목 순") { _ in
            self.todoList = self.repository.fetchSortedTodoList("todoTitle")
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
        todoList = repository.fetchTodoList()
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
}

 // MARK: - UITableView Delegate

extension AllListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AllListTableViewCell.identifier, for: indexPath) as? AllListTableViewCell else { return UITableViewCell() }
        
        cell.selectionStyle = .none
        
        let todo = todoList[indexPath.row]
        cell.todo = todo
        cell.configureTodoCell(todo)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // Swipe Delete
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let targetTodo = todoList[indexPath.row]
            repository.deleteTodo(targetTodo)
            tableView.reloadData()
            
            // Home 화면 count 갱신을 위한 Noti post
            NotificationCenter.default.post(name: AddTodoViewController.allListDidChanged, object: nil)
        }
    }
}
