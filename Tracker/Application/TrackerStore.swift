import UIKit
import CoreData

final class TrackerStore: NSObject {
    
    let appDelegate: AppDelegate
    let context: NSManagedObjectContext
    var delegate: TrackersViewController?
    
    lazy var fetchedResultsController: NSFetchedResultsController<TrackerCoreData> = {
        let request = NSFetchRequest<TrackerCoreData>(entityName: "TrackerCoreData")
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let controller = NSFetchedResultsController<TrackerCoreData>(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        try? controller.performFetch()
        return controller
    }()
    
    override init() {
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.coreDataContainer.viewContext
        self.delegate = nil
    }
    
    func addTracker(event: Event, category: String) throws {
        let tracker = TrackerCoreData(context: context)
        let colorMarshall = UIColorMarshalling()
        tracker.trackerID = event.id
        tracker.color = colorMarshall.hexString(from: event.color)
        tracker.day = event.day?.joined(separator: " ")
        tracker.emoji = event.emoji
        tracker.name = event.name
        try! context.save()
        addCategory(category: category, tracker: tracker)
    }
    
    func addCategory(category: String, tracker: TrackerCoreData) {
        let request = NSFetchRequest<TrackerCategoryCoreData>(entityName: "TrackerCategoryCoreData")
        request.returnsObjectsAsFaults = false
        let trackerCategories = try! context.fetch(request)
        if !trackerCategories.filter({$0.name == category}).isEmpty {
            trackerCategories.forEach { trackerCategory in
                if trackerCategory.name == category {
                    trackerCategory.addToTrackers(tracker)
                }
            }
        } else {
            let newCategory = TrackerCategoryCoreData(context: context)
            newCategory.name = category
            newCategory.id = UUID()
            newCategory.addToTrackers(tracker)
        }
        try! context.save()
    }
    
    func addRecord(id: UUID, day: String) {
        let request = NSFetchRequest<TrackerRecordCoreData>(entityName: "TrackerRecordCoreData")
        request.returnsObjectsAsFaults = false
        let trackerRecords = try! context.fetch(request)
        if trackerRecords.filter({$0.day == day}).isEmpty {
            let record = TrackerRecordCoreData(context: context)
            record.recordID = id
            record.day = day
        }
        try! context.save()
    }
    
    func updateCollectionView() {
        let categoryRequest = NSFetchRequest<TrackerCategoryCoreData>(entityName: "TrackerCategoryCoreData")
        categoryRequest.returnsObjectsAsFaults = false
        let trackerCategories = try! context.fetch(categoryRequest)
        let trackerRequest = NSFetchRequest<TrackerCoreData>(entityName: "TrackerCoreData")
        trackerRequest.returnsObjectsAsFaults = false
        let trackersCD = try! context.fetch(trackerRequest)
        trackers = []
        trackerCategories.forEach { category in
            let newCategoryName = category.name
            var events: [Event] = []
            let colorMarshall = UIColorMarshalling()
            trackersCD.forEach { track in
                if track.category?.name == newCategoryName {
                    events.append(Event(id: track.trackerID ?? UUID(), name: track.name ?? "", emoji: track.emoji ?? "", color: colorMarshall.color(from: track.color ?? ""), day: track.day?.components(separatedBy: " ")))
                }
            }
            let neeeew = [TrackerCategory(label: newCategoryName ?? "", trackers: events)]
            trackers.append(contentsOf: neeeew.sorted(by: {$0.label > $1.label}))
        }
        let recordRequest = NSFetchRequest<TrackerRecordCoreData>(entityName: "TrackerRecordCoreData")
        recordRequest.returnsObjectsAsFaults = false
        let recordsCD = try! context.fetch(recordRequest)
        trackerRecords = []
        recordsCD.forEach { record in
            trackerRecords.append(TrackerRecord(id: record.recordID ?? UUID(), day: record.day ?? ""))
        }
        delegate?.updateCollection()
    }
    
    func deleteTracker(id inID: UUID) {
        let request = NSFetchRequest<TrackerCoreData>(entityName: "TrackerCoreData")
        request.returnsObjectsAsFaults = false
        let predicate = NSPredicate(format: "%K == %@", #keyPath(TrackerCoreData.trackerID), inID.uuidString)
        request.predicate = predicate
        let result = try! context.fetch(request)
        context.delete(result.first ?? TrackerCoreData())
        let recordRequest = NSFetchRequest<TrackerRecordCoreData>(entityName: "TrackerRecordCoreData")
        recordRequest.returnsObjectsAsFaults = false
        let recordPredicate = NSPredicate(format: "%K == %@", #keyPath(TrackerRecordCoreData.recordID), inID.uuidString)
        recordRequest.predicate = recordPredicate
        let records = try! context.fetch(recordRequest)
        context.delete(records.first ?? TrackerRecordCoreData())
        try! context.save()
    }
    
    func deleteRecord(id: UUID, day: String) {
        let request = NSFetchRequest<TrackerRecordCoreData>(entityName: "TrackerRecordCoreData")
        request.returnsObjectsAsFaults = false
        let trackerRecords = try! context.fetch(request)
        context.delete(trackerRecords.filter({$0.day == day}).first ?? TrackerRecordCoreData())
        try! context.save()
    }
    
}

extension TrackerStore: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        updateCollectionView()
        delegate?.datePickerValueChanged(sender: delegate?.datePicker ?? UIDatePicker())
    }
    
}

final class UIColorMarshalling {
    
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
