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
            let recordRequest = NSFetchRequest<TrackerRecordCoreData>(entityName: "TrackerRecordCoreData")
            recordRequest.predicate = NSPredicate(format: "tracker == %@", result.first ?? TrackerCoreData())
            for object in try context.fetch(recordRequest) {
                context.delete(object)
            }
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
        let eventRequest = NSFetchRequest<TrackerCoreData>(entityName: "TrackerCoreData")
        eventRequest.predicate = NSPredicate(format: "trackerID == %@", id.uuidString)
        let event = try! context.fetch(eventRequest).first
        let category = TrackerCategoryCoreData(context: context)
        category.name = "Закреплённые"
        event?.category = category
        try! context.save()
    }
    
    /// Метод, "открепляющий" трекер
    func unpinEvent(id: UUID) -> String {
        let request = NSFetchRequest<PinnedTrackers>(entityName: "PinnedTrackers")
        request.predicate = NSPredicate(format: "pinnedTrackerID == %@", id.uuidString)
        guard let result = try! context.fetch(request).first?.pinnedTrackerCategory else { return "" }
        let eventRequest = NSFetchRequest<TrackerCoreData>(entityName: "TrackerCoreData")
        eventRequest.predicate = NSPredicate(format: "trackerID == %@", id.uuidString)
        let event = try! context.fetch(eventRequest).first
        let categoryRequest = NSFetchRequest<TrackerCategoryCoreData>(entityName: "TrackerCategoryCoreData")
        categoryRequest.predicate = NSPredicate(format: "name == %@", result)
        let category = try! context.fetch(categoryRequest).first
        event?.category = category
        context.delete(try! context.fetch(request).first ?? PinnedTrackers())
        try! context.save()
        return result
    }
    
    /// Метод редактирования трекера
    func editEvent(event: Event, category: String) {
        let eventRequest = NSFetchRequest<TrackerCoreData>(entityName: "TrackerCoreData")
        eventRequest.predicate = NSPredicate(format: "trackerID == %@", event.id.uuidString)
        let eventResult = try! context.fetch(eventRequest).first
        let color = UIColor.hexString(from: event.color)
        eventResult?.color = color
        let day = event.day?.joined(separator: " ")
        eventResult?.day = day
        let emoji = event.emoji
        eventResult?.emoji = emoji
        let name = event.name
        eventResult?.name = name
        let categoryRequest = NSFetchRequest<TrackerCategoryCoreData>(entityName: "TrackerCategoryCoreData")
        categoryRequest.predicate = NSPredicate(format: "name == %@", category)
        var categoryResult = try! context.fetch(categoryRequest).first
        if categoryResult == nil {
            categoryResult = TrackerCategoryCoreData(context: context)
            categoryResult?.name = category
        }
        eventResult?.category = categoryResult
        try! context.save()
    }
    
}
