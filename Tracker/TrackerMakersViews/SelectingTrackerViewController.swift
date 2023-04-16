//
//  SelectingTrackerViewController.swift
//  Tracker
//
//  Created by Илья Тимченко on 16.04.2023.
//

import UIKit

final class SelectingTrackerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSelecter()
    }
    
    private func setupSelecter() {
        view.backgroundColor = .white
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = "Создание трекера"
            label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let habitButton: UIButton = {
            let button = UIButton()
            button.backgroundColor = .black
            button.setTitle("Привычка", for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            button.layer.cornerRadius = 16
            button.addTarget(nil, action: #selector(habitTapped), for: .touchUpInside)
            return button
        }()
        
        let irregularEventButton: UIButton = {
            let button = UIButton()
            button.backgroundColor = .black
            button.setTitle("Нерегулярное событие", for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            button.layer.cornerRadius = 16
            button.addTarget(nil, action: #selector(irregularTapped), for: .touchUpInside)
            return button
        }()
        
        let stackView: UIStackView = {
            let stack = UIStackView()
            stack.addArrangedSubview(habitButton)
            stack.addArrangedSubview(irregularEventButton)
            stack.axis = .vertical
            stack.alignment = .fill
            stack.distribution = .fill
            stack.spacing = 8.0
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
        
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 27),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            habitButton.heightAnchor.constraint(equalToConstant: 60),
            irregularEventButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
    }
    
    @objc
    private func irregularTapped() {
        let irregularEventVC = NewIrregularEventControllerView()
        show(irregularEventVC, sender: self)
    }
    
    @objc
    private func habitTapped() {
        let habitVC = NewHabitViewController()
        show(habitVC, sender: self)
    }
}
