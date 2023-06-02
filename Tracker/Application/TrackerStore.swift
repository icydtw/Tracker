import UIKit
import CoreData

/// Класс, работающий с трекерами в БД
final class TrackerStore: NSObject {
    //MARK: - Свойства
    let context: NSManagedObjectContext
    
    // MARK: - Методы
    override init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.context
    }
    
    /// Метод, добавляющий в БД новый трекер
    func addTracker(event: Event, category: String, categoryViewModel: CategoryViewModel) -> Bool {
        let tracker = TrackerCoreData(context: context)
        tracker.trackerID = event.id
        tracker.color = UIColor.hexString(from: event.color)
        tracker.day = event.day?.joined(separator: " ")
        tracker.emoji = event.emoji
        tracker.name = event.name
        do {
            try context.save()
        } catch {
            return false
        }
        categoryViewModel.addCategoryStruct(category: category, tracker: tracker)
        return true
    }
    
    /// Метод, удаляющий трекер из БД
    func deleteTracker(id inID: UUID) -> Bool {
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
            return false
        }
         return true
    }
    
    /// Метод, "закрепляющий" трекер
    func pinEvent(oldCategory: String, id: UUID) {
        let pinnedTracker = PinnedTrackers(context: context)
        pinnedTracker.pinnedTrackerID = id
        pinnedTracker.pinnedTrackerCategory = oldCategory
        try! context.save()
        let request = NSFetchRequest<PinnedTrackers>(entityName: "PinnedTrackers")
    }
    
    /// Метод, "открепляющий" трекер
    func unpinEvent(id: UUID) -> String {
        let request = NSFetchRequest<PinnedTrackers>(entityName: "PinnedTrackers")
        request.predicate = NSPredicate(format: "pinnedTrackerID == %@", id.uuidString)
        guard let result = try! context.fetch(request).first?.pinnedTrackerCategory else { return "" }
        context.delete(try! context.fetch(request).first ?? PinnedTrackers())
        return result
    }
    
}
