//
//  ViewController.swift
//  OskiTodo
//
//  Created by Justin Wong on 8/10/24.
//

import UIKit

struct Todo {
    var name: String
    var date: Date
    var isCompleted: Bool
}

class ViewController: UIViewController {
    
    private let button = UIButton(type: .custom)
    private let todoTableView = UITableView()
    
    private var todos: [Todo] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        configureCreateTodoButton()
        configureTodoTableView()
    }
    
    private func configureCreateTodoButton() {
        button.setTitle("Create Todo", for: .normal)
        button.titleLabel?.textColor = UIColor.white
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 20
    
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        button.addTarget(self, action: #selector(presentNewTodoVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            button.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc internal func presentNewTodoVC() {
        let newTodoVC = NewTodoViewController()
        newTodoVC.delegate = self
        
        let navController = UINavigationController(rootViewController: newTodoVC)
        present(navController, animated: true)
    }
    
    private func configureTodoTableView() {
       
        todoTableView.delegate = self
        todoTableView.dataSource = self
        todoTableView.backgroundColor = .systemRed
        todoTableView.register(TodoCell.self, forCellReuseIdentifier: TodoCell.reuseID)
        
        view.addSubview(todoTableView)
        todoTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            todoTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            todoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            todoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            todoTableView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -30)
        ])
    }

}


// MARK: - UITableView Delegates

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let todoCell = tableView.dequeueReusableCell(withIdentifier: TodoCell.reuseID) as? TodoCell {
            todoCell.setTodo(for: todos[indexPath.row])
            return todoCell
        }
        
        return UITableViewCell()
    }
    
}


// MARK: - NewTodoViewControllerDelegate

extension ViewController: NewTodoViewControllerDelegate {
    func createTodo(title: String?) {
        guard let title else {
            return
        }
        
        todos.append(Todo(name: title, date: Date(), isCompleted: false))
        todoTableView.reloadData()
        
        dismiss(animated: true)
        
    }
}


// MARK: - TodoCell

class TodoCell: UITableViewCell {
    
    static let reuseID = "TodoCell"
    
    private let todoNameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureTodoCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTodo(for todo: Todo) {
        todoNameLabel.text = todo.name
    }
    
    private func configureTodoCell() {
      
        todoNameLabel.text = "Todo"
        todoNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        addSubview(todoNameLabel)
        todoNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            todoNameLabel.topAnchor.constraint(equalTo: topAnchor),
            todoNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            todoNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            todoNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}

