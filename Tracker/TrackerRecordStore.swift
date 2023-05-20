import Foundation
import CoreData

final class TrackerRecordStore {
    
    // MARK: - Метод, добавляющий +1 к счётчику выполненных трекеров
    func addRecord(id: UUID, day: String, context: NSManagedObjectContext) {
        let request = NSFetchRequest<TrackerCoreData>(entityName: "TrackerCoreData")
        request.returnsObjectsAsFaults = false
        let trackers = try! context.fetch(request)
        let newRecord = TrackerRecordCoreData(context: context)
        newRecord.day = day
        newRecord.tracker = trackers.filter({$0.trackerID == id}).first
        try! context.save()
    }
    
    // MARK: - Метод, снимающий -1 от счётчика трекеров
    func deleteRecord(id: UUID, day: String, context: NSManagedObjectContext) {
        let request = NSFetchRequest<TrackerRecordCoreData>(entityName: "TrackerRecordCoreData")
        request.returnsObjectsAsFaults = false
        let records = try! context.fetch(request)
        context.delete(records.filter({$0.tracker?.trackerID == id && $0.day == day}).first ?? NSManagedObject())
        try! context.save()
    }
    
}
