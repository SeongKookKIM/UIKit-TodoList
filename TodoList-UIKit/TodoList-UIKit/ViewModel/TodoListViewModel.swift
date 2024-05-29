//
//  TodoListViewModel.swift
//  TodoList-UIKit
//
//  Created by SeongKook on 5/28/24.
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


class TodoStore {
    static let shared = TodoStore()
    private var todoList: [Todo] {
         didSet { // 속성의 값이 변경된 후에 호출
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
    

    
    func updateTodo(_ updatedTodo: Todo) {
        if let index = todoList.firstIndex(where: { $0.id == updatedTodo.id }) {
            todoList[index] = updatedTodo
        }
    }
}
