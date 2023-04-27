//
//  EmojiCollectionData.swift
//  Tracker
//
//  Created by Илья Тимченко on 17.04.2023.
//

import UIKit

let event = Event(name: "Уборка", category: "Домашние дела", emoji: "🙂", color: UIColor(red: 0.902, green: 0.427, blue: 0.831, alpha: 1), day: nil)

var events: [Event] = []

let emojiCollectionData = ["🙂", "😻", "🌺", "🐶", "❤️", "😱", "😇", "😡", "🥶", "🤔", "🙌", "🍔", "🥦", "🏓", "🥇", "🎸", "🏝", "😪"]

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

var categories = [
    "Домашние дела", "Хобби", "Работа", "Учёба", "Спорт"
]

var categoryName = ""

enum dayOfWeek: String {
    case monday = "понедельник"
    case tuesday = "вторник"
    case wednesday = "среда"
    case thursday = "четверг"
    case friday = "пятница"
    case saturday = "суббота"
    case sunday = "воскресенье"
}

let daysOfWeek: [dayOfWeek] = [.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday]

