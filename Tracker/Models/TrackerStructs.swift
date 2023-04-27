import UIKit

/// Структура для создания объектов событий (привычек или нерегулярных событий)
struct Event {
    
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
