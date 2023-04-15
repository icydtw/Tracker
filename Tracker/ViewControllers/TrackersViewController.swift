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
            let button = UIButton()
            button.setImage(UIImage(systemName: "plus"), for: .normal)
            button.frame = CGRect(x: 0, y: 0, width: 19, height: 18)
            button.addTarget(nil, action: #selector(plusTapped), for: .touchUpInside)
            return button
        }()
        
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(plusButton)
        NSLayoutConstraint.activate([
            plusButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            plusButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }
    
    @objc
    private func plusTapped() {
        print("Plus tapped")
    }
    
}
