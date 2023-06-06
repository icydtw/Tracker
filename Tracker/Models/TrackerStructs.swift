import UIKit

/// Структура для создания объектов событий (привычек или нерегулярных событий)
struct Event {
    
    // MARK: - Свойства
    let id: UUID
    var name: String
    var emoji: String
    var color: UIColor
    var day: [String]?
    
    // MARK: - Методы
    /// Инициализатор
    init(id: UUID = UUID(), name: String, emoji: String, color: UIColor, day: [String]?) {
        self.id = id
        self.name = name
        self.emoji = emoji
        self.color = color
        self.day = day
    }
    
}

/// Структура, объединяющая Event'ы по категориям
struct TrackerCategory {
    
    // MARK: - Свойства
    let label: String
    let trackers: [Event]
    
    // MARK: - Методы
    /// Инициализатор
    init(label: String, trackers: [Event]) {
        self.label = label
        self.trackers = trackers
    }
    
}

/// Структура записей о выполнении трекеров
struct TrackerRecord {
    
    // MARK: - Свойства
    let id: UUID
    var day: String
    
    // MARK: - Методы
    /// Инициализатор
    init(id: UUID, day: String) {
        self.id = id
        self.day = day
    }
}

/// Структура для экрана статистики
struct Statistics {
    
    // MARK: - Свойства
    var endedTracks: Int
    
    // MARK: - Методы
    init(endedTracks: Int) {
        self.endedTracks = endedTracks
    }
}
