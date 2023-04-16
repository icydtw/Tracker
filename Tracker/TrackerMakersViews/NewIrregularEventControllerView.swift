//
//  NewIrregularEventControllerView.swift
//  Tracker
//
//  Created by Илья Тимченко on 16.04.2023.
//

import UIKit

final class NewIrregularEventControllerView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupIrregularViewController()
    }
    
    private func setupIrregularViewController() {
        view.backgroundColor = .white
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = "Новое нерегулярное событие"
            label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let enterNameTextField: UITextField = {
            let field = UITextField()
            field.placeholder = "Введите название трекера"
            field.backgroundColor = UIColor(red: 0.902, green: 0.91, blue: 0.922, alpha: 0.3)
            field.layer.cornerRadius = 16
            field.translatesAutoresizingMaskIntoConstraints = false
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: field.frame.height))
            field.leftView = paddingView
            field.leftViewMode = .always
            return field
        }()
        
        view.addSubview(titleLabel)
        view.addSubview(enterNameTextField)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 27),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            enterNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            enterNameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 38),
            enterNameTextField.heightAnchor.constraint(equalToConstant: 75),
            enterNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }
    
}
