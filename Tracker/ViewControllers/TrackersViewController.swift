//
//  ViewController.swift
//  Tracker
//
//  Created by Илья Тимченко on 24.03.2023.
//

import UIKit

class TrackersViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTrackers()
    }
    
}

extension TrackersViewController {
    
    private func setupTrackers() {
        view.backgroundColor = .white
        
        let plusButton: UIButton = {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 19, height: 18))
            let image = UIImage(systemName: "plus")
            let imageView = UIImageView(image: image)
            imageView.tintColor = .black
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.frame = button.bounds
            button.addSubview(imageView)
            button.addTarget(nil, action: #selector(plusTapped), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        let trackersLabel: UILabel = {
            let label = UILabel()
            label.text = "Трекеры"
            label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let datePicker: UIDatePicker = {
            let datePicker = UIDatePicker()
            datePicker.preferredDatePickerStyle = .compact
            datePicker.datePickerMode = .date
            datePicker.translatesAutoresizingMaskIntoConstraints = false
            datePicker.locale = Locale(identifier: "ru_RU")
            return datePicker
        }()
        
        let starImage = UIImageView(image: UIImage(named: "star"))
        starImage.translatesAutoresizingMaskIntoConstraints = false
        
        let questionLabel: UILabel = {
            let label = UILabel()
            label.text = "Что будем отслеживать?"
            label.translatesAutoresizingMaskIntoConstraints = false
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
        
        view.addSubview(plusButton)
        view.addSubview(trackersLabel)
        view.addSubview(datePicker)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            plusButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            plusButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            plusButton.widthAnchor.constraint(equalToConstant: 19),
            plusButton.heightAnchor.constraint(equalToConstant: 18),
            trackersLabel.topAnchor.constraint(equalTo: plusButton.bottomAnchor, constant: 13),
            trackersLabel.leadingAnchor.constraint(equalTo: plusButton.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            datePicker.topAnchor.constraint(equalTo: plusButton.bottomAnchor, constant: 13),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
    
    @objc
    private func plusTapped() {
        let selecterTrackerVC = SelectingTrackerViewController()
        show(selecterTrackerVC, sender: self)
    }
    
}
