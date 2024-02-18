//
//  SavedViewController.swift
//  SESAC-ToDoApp
//
//  Created by Seryun Chun on 2024/02/19.
//

import UIKit
import RealmSwift

class CompleteViewController: BaseViewController {
    
    let repository = TodoTableRepository()
    
    var completeTodoList: Results<TodoTable>!
    
     // MARK: - UI Property
    
    var completeTableView = UITableView()

     // MARK: - Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        completeTodoList = repository.fetchCompletedList()
    }
    
     // MARK: - UI Configuration Method
    
    override func render() {
        view.addSubview(completeTableView)
        completeTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureTableView() {
        completeTableView.delegate = self
        completeTableView.dataSource = self
    }
}

 // MARK: - UITableView Delegate

extension CompleteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completeTodoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AllListTableViewCell.identifier, for: indexPath) as? AllListTableViewCell else { return UITableViewCell() }
        
        let todo = completeTodoList[indexPath.row]
        cell.configureTodoCell(todo)
        
        return cell
    }
    
    
}
