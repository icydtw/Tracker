//
//  HabitCategoryCellsViewController.swift
//  Tracker
//
//  Created by Илья Тимченко on 26.04.2023.
//

import UIKit

final class HabitCategoryCellsViewController: UITableViewCell {
    
    let title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let arrow: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "arrow")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var categoryName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = UIColor(red: 0.682, green: 0.686, blue: 0.706, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellViewController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCellViewController() {
        
        contentView.addSubview(title)
        contentView.addSubview(arrow)
        contentView.addSubview(categoryName)
        
        contentView.backgroundColor = UIColor(red: 0.902, green: 0.91, blue: 0.922, alpha: 0.3)
        
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            arrow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            arrow.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
//        NotificationCenter.default.addObserver(self, selector: #selector(myNotificationHandler), name: Notification.Name("category_changed"), object: nil)
        
    }
    
    @objc private func myNotificationHandler() {
        
        title.removeFromSuperview()
        contentView.addSubview(title)
        
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            categoryName.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 2),
            categoryName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
        ])

        contentView.layoutIfNeeded()
        contentView.updateConstraints()
    }
    
}
