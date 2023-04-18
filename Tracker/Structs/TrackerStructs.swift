//
//  TrackerStructs.swift
//  Tracker
//
//  Created by Илья Тимченко on 18.04.2023.
//

import UIKit

@objc
class IrregularEvent: NSObject {
    var name: String
    var category: String?
    var emoji: String?
    var color: UIColor?
    
    @objc
    init(name: String, category: String? = nil, emoji: String? = nil, color: UIColor? = nil) {
        self.name = name
        self.category = category
        self.emoji = emoji
        self.color = color
    }
}
