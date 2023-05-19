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
    }
}
