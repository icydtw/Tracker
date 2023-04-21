//
//  NewHabitViewController.swift
//  Tracker
//
//  Created by Илья Тимченко on 16.04.2023.
//

import UIKit

final class NewHabitViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Новая привычка"
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHabitViewController()
    }
    
    private func setupHabitViewController() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(enterNameTextField)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 27),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            
        ])
    }
    
}
