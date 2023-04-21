//
//  CategoryCells.swift
//  Tracker
//
//  Created by Илья Тимченко on 21.04.2023.
//

import UIKit

final class CategoryCellsViewController: UITableViewCell {
    
    let title: UILabel = {
        let label = UILabel()
        label.text = "Категория"
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var categoryName: UILabel = {
        let label = UILabel()
        label.text = "Выберите категорию"
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = UIColor(red: 0.682, green: 0.686, blue: 0.706, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let arrow: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "arrow")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
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
        contentView.addSubview(categoryName)
        contentView.addSubview(arrow)
        contentView.backgroundColor = UIColor(red: 0.902, green: 0.91, blue: 0.922, alpha: 0.3)
        contentView.layer.cornerRadius = 16
        
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            categoryName.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 2),
            categoryName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            arrow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            arrow.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
