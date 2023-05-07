import UIKit

/// Файл, в котором хранятся основные данные для работы приложения

// MARK: - Массив всех событий, создаваемых пользователем
var events: [Event] = []
var trackers: [TrackerCategory] = []

// MARK: - Массив с emoji, используемыми в приложении
let emojiCollectionData = ["🙂", "😻", "🌺", "🐶", "❤️", "😱", "😇", "😡", "🥶", "🤔", "🙌", "🍔", "🥦", "🏓", "🥇", "🎸", "🏝", "😪"]

// MARK: - Массив с цветами, используемыми в приложении
let colorCollectionData = [
    UIColor(red: 0.992, green: 0.298, blue: 0.286, alpha: 1),
    UIColor(red: 1, green: 0.533, blue: 0.118, alpha: 1),
    UIColor(red: 0, green: 0.482, blue: 0.98, alpha: 1),
    UIColor(red: 0.431, green: 0.267, blue: 0.996, alpha: 1),
    UIColor(red: 0.2, green: 0.812, blue: 0.412, alpha: 1),
    UIColor(red: 0.902, green: 0.427, blue: 0.831, alpha: 1),
    UIColor(red: 0.976, green: 0.831, blue: 0.831, alpha: 1),
    UIColor(red: 0.204, green: 0.655, blue: 0.996, alpha: 1),
    UIColor(red: 0.275, green: 0.902, blue: 0.616, alpha: 1),
    UIColor(red: 0.208, green: 0.204, blue: 0.486, alpha: 1),
    UIColor(red: 1, green: 0.404, blue: 0.302, alpha: 1),
    UIColor(red: 1, green: 0.6, blue: 0.8, alpha: 1),
    UIColor(red: 0.965, green: 0.769, blue: 0.545, alpha: 1),
    UIColor(red: 0.475, green: 0.58, blue: 0.961, alpha: 1),
    UIColor(red: 0.514, green: 0.173, blue: 0.945, alpha: 1),
    UIColor(red: 0.678, green: 0.337, blue: 0.855, alpha: 1),
    UIColor(red: 0.553, green: 0.447, blue: 0.902, alpha: 1),
    UIColor(red: 0.184, green: 0.816, blue: 0.345, alpha: 1)
]

// MARK: - Массив с категориями, используемыми в приложении
var categories = [
    "Домашние дела", "Хобби", "Работа", "Учёба", "Спорт"
]

// MARK: - Переменная, хранящая выбранную пользователем категорию события
var categoryName = ""

// MARK: - Перечисление с днями недели
enum dayOfWeek: String {
    case monday = "понедельник"
    case tuesday = "вторник"
    case wednesday = "среда"
    case thursday = "четверг"
    case friday = "пятница"
    case saturday = "суббота"
    case sunday = "воскресенье"
}

// MARK: - Массив дней недели
let daysOfWeek: [dayOfWeek] = [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday]

// MARK: - Массив с выбранными пользователем днями недели для события
var selectedDays: [String] = []
var shortSelectedDays: [String] = []

// MARK: - Массив существующих на экране "Трекеры" заголовков
var titles: [String] = []

// MARK: - Массив, хранящий в какие дни какие трекеры выполнялись
var trackerRecords: [TrackerRecord] = []
