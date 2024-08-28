//
//  NewTodoViewController.swift
//  OskiTodo
//
//  Created by Justin Wong on 8/17/24.
//

import UIKit

protocol NewTodoViewControllerDelegate: AnyObject {
    func createTodo(title: String?)
}

class NewTodoViewController: UIViewController {
    
    
    private let textField = UITextField()
    
    weak var delegate: NewTodoViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.title = "Create New Todo"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(createTodo))
        
        createTodoNameView()
    }
    
    @objc private func createTodo() {
        delegate?.createTodo(title: textField.text)
    }
    
    private func createTodoNameView()  {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        
        let todoNameLabel = UILabel()
        todoNameLabel.text = "Todo Name:"
        todoNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)

        textField.placeholder = "New Todo Name"
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(todoNameLabel)
        stackView.addArrangedSubview(textField)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            
            textField.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            textField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}

#Preview {
    return NewTodoViewController()
}


