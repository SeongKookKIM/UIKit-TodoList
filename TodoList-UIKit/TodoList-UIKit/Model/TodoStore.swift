//
//  TodoStore.swift
//  TodoList-UIKit
//
//  Created by mac on 5/25/24.
//

import Foundation

extension UserDefaults {
    private enum Keys {
        static let todoList = "todoList"
    }
    
    func saveTodoList(_ todos: [Todo]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(todos) {
            self.set(encoded, forKey: Keys.todoList)
        }
    }
    
    func loadTodoList() -> [Todo] {
        if let savedTodos = self.data(forKey: Keys.todoList) {
            let decoder = JSONDecoder()
            if let loadedTodos = try? decoder.decode([Todo].self, from: savedTodos) {
                return loadedTodos
            }
        }
        return []
    }
}


struct Todo: Identifiable, Codable {
    let id: UUID
    let title: String
    let content: String
    let date: Date?
    var isDone: Bool
}

class TodoStore {
    static let shared = TodoStore()
    private var todoList: [Todo] {
         didSet {
             UserDefaults.standard.saveTodoList(todoList)
         }
     }
    
    var listCount: Int {
        return todoList.count
    }
    
    private init() {
        self.todoList = UserDefaults.standard.loadTodoList()
    }
    
    func addTodo(todo: Todo) {
        todoList.append(todo)
    }
    
    func removeTodo(at index: Int) {
        todoList.remove(at: index)
    }
    
    func getTodo(at: IndexPath) -> Todo {
        return todoList[at.row]
    }
    
    func getList() -> [Todo] {
        let list = todoList
        return list
    }
    
    func updateTodo(_ updatedTodo: Todo) {
        if let index = todoList.firstIndex(where: { $0.id == updatedTodo.id }) {
            todoList[index] = updatedTodo
        }
    }
}
