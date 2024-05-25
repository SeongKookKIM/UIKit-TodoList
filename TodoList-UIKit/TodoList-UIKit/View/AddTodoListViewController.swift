//
//  AddTodoListViewController.swift
//  TodoList-UIKit
//
//  Created by mac on 5/24/24.
//

import UIKit


class AddTodoListViewController: UIViewController, UITableViewDataSource, UITextViewDelegate, UITextFieldDelegate  {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "addCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    let todoTitle = UITextField()
    let todoContent = UITextView()
    let addButton = UIButton()
    
    lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapHanlder))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.title = "Add Todo"
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(containerView)
        
        containerView.addSubview(tableView)
        
        
        var config = UIButton.Configuration.filled()
        config.title = "저장하기"
        config.cornerStyle = .capsule
        config.baseBackgroundColor = .systemBrown
        addButton.configuration = config
        addButton.isEnabled = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        addButton.addAction(UIAction{ [weak self] _ in
            guard let self = self else { return }
            
            let newTodo = Todo(
                id: UUID(),
                title: self.todoTitle.text ?? "",
                content: self.todoContent.text ?? "",
                date: Date(),
                isDone: false
            )
            
            TodoStore.shared.addTodo(todo: newTodo)
            
            self.navigationController?.popViewController(animated: true)
        }, for: .touchUpInside)
        
        self.view.addSubview(addButton)
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -20),
            
            tableView.topAnchor.constraint(equalTo: containerView.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            addButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            addButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
            addButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // 탭 제스쳐
        view.addGestureRecognizer(tapGesture)
    }

    
    // MARK: - UITextViewDelegate
    func textViewDidChange(_ textView: UITextView) {
        updateSaveButtonState()
    }
    
    // MARK: - UITextFieldDelegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        DispatchQueue.main.async { [weak self] in
            self?.updateSaveButtonState()
        }
        return true
    }
    
    // MARK: Methods
    func updateSaveButtonState() {
        guard let title = todoTitle.text, !title.isEmpty,
              let body = todoContent.text, !body.isEmpty else {
            addButton.isEnabled = false
            return
        }
        addButton.isEnabled = true
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "제목"
        case 1:
            return "내용"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addCell", for: indexPath)
        cell.contentView.subviews.forEach({view in view.removeFromSuperview()})
        
        switch indexPath.section {
        case 0:
            todoTitle.placeholder = "제목을 적어주세요."
            todoTitle.delegate = self
            todoTitle.translatesAutoresizingMaskIntoConstraints = false
            
            cell.contentView.addSubview(todoTitle)
            
            NSLayoutConstraint.activate([
                todoTitle.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -15),
                todoTitle.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 15),
                todoTitle.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 10),
                todoTitle.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -10)
            ])
            
        case 1:
            todoContent.delegate = self
            todoContent.translatesAutoresizingMaskIntoConstraints = false
            
            cell.contentView.addSubview(todoContent)
            
            NSLayoutConstraint.activate([
                todoContent.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -15),
                todoContent.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 15),
                todoContent.topAnchor.constraint(equalTo: cell.contentView.topAnchor, constant: 10),
                todoContent.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor, constant: -10),
                todoContent.heightAnchor.constraint(equalToConstant: 150)
            ])
            
        default:
            break
        }
        
        return cell
    }
    
    

    // 탭 핸들러
    @objc func tapHanlder(_ sender: UIView) {
        todoTitle.resignFirstResponder()
        todoContent.resignFirstResponder()
    }
    
}
