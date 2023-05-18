import UIKit
import CoreData

final class TrackerStore {
    let appDelegate: AppDelegate
    let context: NSManagedObjectContext
    
    init() {
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.coreDataContainer.viewContext
    }
    
    func addTracker(event: Event) throws {
        let tracker = TrackerCoreData(context: context)
        tracker.id = event.id
        tracker.color = event.color
        tracker.day = tracker.day
        tracker.emoji = event.emoji
        tracker.name = event.name
        try! context.save()
        print(try context.existingObject(with: tracker.objectID))
    }
}
