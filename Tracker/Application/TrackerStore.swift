import UIKit
import CoreData

/// Класс, работающий с трекерами в БД
final class TrackerStore {
    
    // MARK: - Метод, добавляющий в БД новый трекер
    func addTracker(event: Event, category: String, context: NSManagedObjectContext, trackerCategoryStore: TrackerCategoryStore) {
        let tracker = TrackerCoreData(context: context)
        let colorMarshall = UIColorMarshalling()
        tracker.trackerID = event.id
        tracker.color = colorMarshall.hexString(from: event.color)
        tracker.day = event.day?.joined(separator: " ")
        tracker.emoji = event.emoji
        tracker.name = event.name
        do {
            try context.save()
        } catch {
            AlertMessage.shared.displayErrorAlert(title: "Ошибка!", message: "Ошибка сохранения данных")
        }
        trackerCategoryStore.addCategory(category: category, tracker: tracker, context: context)
    }
    
    // MARK: - Метод, удаляющий трекер из БД
    func deleteTracker(id inID: UUID, context: NSManagedObjectContext) {
        let request = NSFetchRequest<TrackerCoreData>(entityName: "TrackerCoreData")
        request.returnsObjectsAsFaults = false
        let predicate = NSPredicate(format: "%K == %@", #keyPath(TrackerCoreData.trackerID), inID.uuidString)
        request.predicate = predicate
        var result: [TrackerCoreData] = []
        do {
            result = try context.fetch(request)
        } catch {
            AlertMessage.shared.displayErrorAlert(title: "Ошибка!", message: "Ошибка получения данных")
        }
        context.delete(result.first ?? TrackerCoreData())
        do {
            try context.save()
        } catch {
            AlertMessage.shared.displayErrorAlert(title: "Ошибка!", message: "Ошибка сохранения данных")
        }
    }

}

/// Класс, необходимый для конвертации цвета в строку и наоборот
final class UIColorMarshalling {
    
    // MARK: - Метод для конвертации цвета в строку
    func hexString(from color: UIColor) -> String {
        let components = color.cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0
        return String.init(
            format: "%02lX%02lX%02lX",
            lroundf(Float(r * 255)),
            lroundf(Float(g * 255)),
            lroundf(Float(b * 255))
        )
    }

    // MARK: - Метод для конвертации строки обратно в цвет
    func color(from hex: String) -> UIColor {
        var rgbValue:UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
