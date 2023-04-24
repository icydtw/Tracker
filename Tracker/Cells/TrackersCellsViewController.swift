//
//  TrackersCellsViewController.swift
//  Tracker
//
//  Created by Илья Тимченко on 24.04.2023.
//

import UIKit

final class TrackersCellsViewController: UICollectionViewCell {
    
    var emoji: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    var name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(emoji)
        contentView.addSubview(name)
        
        NSLayoutConstraint.activate([
            emoji.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            emoji.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            name.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            name.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
