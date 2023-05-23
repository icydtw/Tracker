import UIKit
import CoreData

/// Класс, работающий с трекерами в БД
final class TrackerStore {
    
    // MARK: - Метод, добавляющий в БД новый трекер
    func addTracker(event: Event, category: String, context: NSManagedObjectContext, trackerCategoryStore: TrackerCategoryStore) {
        let tracker = TrackerCoreData(context: context)
        tracker.trackerID = event.id
        tracker.color = UIColor.hexString(from: event.color)
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
