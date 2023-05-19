import UIKit
import CoreData

final class TrackerStore {
    
    let appDelegate: AppDelegate
    let context: NSManagedObjectContext
    
    init() {
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.coreDataContainer.viewContext
    }
    
    func addTracker(event: Event, category: String) throws {
        let tracker = TrackerCoreData(context: context)
        tracker.id = event.id
        tracker.color = event.color.description
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
    
}
