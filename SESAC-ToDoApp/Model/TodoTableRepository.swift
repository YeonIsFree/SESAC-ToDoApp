//
//  TodoTableRepository.swift
//  SESAC-ToDoApp
//
//  Created by Seryun Chun on 2024/02/19.
//

import Foundation
import RealmSwift

final class TodoTableRepository {
    
    private let realm = try! Realm()
    
    // Create
    func createTodo(_ todo: TodoTable) {
        do {
            try realm.write {
                realm.add(todo)
                print("Realm Saved--")
            }
        } catch {
            print(error)
        }
    }
    
    // Read
    func fetchTodoList() -> Results<TodoTable> {
        return realm.objects(TodoTable.self)
    }
    
    func fetchSortedTodoList(_ keyPath: String) -> Results<TodoTable> {
        return realm.objects(TodoTable.self).sorted(byKeyPath: keyPath)
    }
    
    func fetchCompletedList() -> Results<TodoTable> {
        return realm.objects(TodoTable.self).where { $0.isCompleted == true }
    }
    
    // Update
    func updateTodoStatus(_ todo: TodoTable) {
        do {
            try realm.write {
                todo.isCompleted.toggle()
                print(todo.isCompleted)
            }
        } catch {
            print("update error", error)
        }
    }
    
    // Delete
    func deleteTodo(_ target: TodoTable) {
        do {
            try realm.write {
                realm.delete(target)
            }
        } catch {
            print("delete error", error)
        }
    }
    
}
