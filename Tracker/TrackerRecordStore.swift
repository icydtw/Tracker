import UIKit
import CoreData

final class TrackerRecordStore: NSObject {
    // MARK: - Свойства
    let context: NSManagedObjectContext
    
    // MARK: - Методы
    override init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.context
    }
    
    /// Метод, добавляющий +1 к счётчику выполненных трекеров
    func addRecord(id: UUID, day: String) {
        let request = NSFetchRequest<TrackerCoreData>(entityName: "TrackerCoreData")
        request.returnsObjectsAsFaults = false
        var trackers: [TrackerCoreData] = []
        do {
            trackers = try context.fetch(request)
        } catch {
            AlertMessage.shared.displayErrorAlert(title: "Ошибка!", message: "Ошибка получения данных")
        }
        let newRecord = TrackerRecordCoreData(context: context)
        newRecord.day = day
        newRecord.tracker = trackers.filter({$0.trackerID == id}).first
        do {
            try context.save()
        } catch {
            AlertMessage.shared.displayErrorAlert(title: "Ошибка!", message: "Ошибка сохранения данных")
        }
    }
    
    /// Метод, снимающий -1 от счётчика трекеров
    func deleteRecord(id: UUID, day: String) {
        let request = NSFetchRequest<TrackerRecordCoreData>(entityName: "TrackerRecordCoreData")
        request.returnsObjectsAsFaults = false
        var records: [TrackerRecordCoreData] = []
        do {
            records = try context.fetch(request)
        } catch {
            AlertMessage.shared.displayErrorAlert(title: "Ошибка!", message: "Ошибка сохранения данных")
        }
        context.delete(records.filter({$0.tracker?.trackerID == id && $0.day == day}).first ?? NSManagedObject())
        do {
            try context.save()
        } catch {
            AlertMessage.shared.displayErrorAlert(title: "Ошибка!", message: "Ошибка сохранения данных")
        }
    }
    
}
