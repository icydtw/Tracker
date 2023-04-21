//
//  choiceOfCategoryViewController.swift
//  Tracker
//
//  Created by Илья Тимченко on 21.04.2023.
//

import UIKit

final class ChoiceOfCategoryViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCategoryViewController()
    }
    
    private func setupCategoryViewController() {
        view.backgroundColor = .white
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = "Категория"
            label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let starImage = UIImageView(image: UIImage(named: "star"))
        starImage.translatesAutoresizingMaskIntoConstraints = false
        
        let questionLabel: UILabel = {
            let label = UILabel()
            label.text = """
            Привычки и события можно
            объединить по смыслу
            """
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 2
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 12)
            return label
        }()
        
        let stackView: UIStackView = {
            let stack = UIStackView()
            stack.addArrangedSubview(starImage)
            stack.addArrangedSubview(questionLabel)
            stack.axis = .vertical
            stack.alignment = .center
            stack.distribution = .fillProportionally
            stack.spacing = 8.0
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
        
        let addCategoryButton: UIButton = {
            let button = UIButton()
            button.backgroundColor = .black
            button.setTitle("Добавить категорию", for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            button.layer.cornerRadius = 16
            button.translatesAutoresizingMaskIntoConstraints = false
            //button.addTarget(nil, action: #selector(irregularTapped), for: .touchUpInside)
            return button
        }()
        
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        view.addSubview(addCategoryButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 27),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addCategoryButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            addCategoryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addCategoryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addCategoryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addCategoryButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
}
