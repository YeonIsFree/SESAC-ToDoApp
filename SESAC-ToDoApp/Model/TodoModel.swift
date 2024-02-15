//
//  TodoModel.swift
//  SESAC-ToDoApp
//
//  Created by Seryun Chun on 2024/02/15.
//

import Foundation
import RealmSwift

class TodoTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var todoTitle: String
    @Persisted var todoMemo: String
    @Persisted var date: String
    @Persisted var tag: String
    @Persisted var priority: String
    
    convenience init(todoTitle: String, todoMemo: String, date: String, tag: String, priority: String) {
        self.init()
        self.todoTitle = todoTitle
        self.todoMemo = todoMemo
        self.date = date
        self.tag = tag
        self.priority = priority
    }
}
