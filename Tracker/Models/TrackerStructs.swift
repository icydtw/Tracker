//
//  TrackerStructs.swift
//  Tracker
//
//  Created by Илья Тимченко on 18.04.2023.
//

import UIKit

struct IrregularEvent {
    var name: String
    var category: String
    var emoji: String
    var color: UIColor
    var day: dayOfWeek?
    
    init(name: String, category: String, emoji: String, color: UIColor, day: dayOfWeek?) {
        self.name = name
        self.category = category
        self.emoji = emoji
        self.color = color
        self.day = day
    }
}
