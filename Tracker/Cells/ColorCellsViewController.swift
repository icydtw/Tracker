//
//  ColorCellsViewController.swift
//  Tracker
//
//  Created by Илья Тимченко on 18.04.2023.
//

import UIKit

final class ColorCellsViewController: UICollectionViewCell {
    
    let color = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        color.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(color)
        color.layer.cornerRadius = 6
        color.layer.masksToBounds = true
        NSLayoutConstraint.activate([
            color.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            color.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            color.heightAnchor.constraint(equalToConstant: 30),
            color.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
