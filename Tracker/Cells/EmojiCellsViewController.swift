//
//  EmojiCellsViewController.swift
//  Tracker
//
//  Created by Илья Тимченко on 17.04.2023.
//

import UIKit

final class EmojiCellsViewController: UICollectionViewCell {
    
    let emojiLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        emojiLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(emojiLabel)
        
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        NSLayoutConstraint.activate([
            emojiLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            emojiLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
