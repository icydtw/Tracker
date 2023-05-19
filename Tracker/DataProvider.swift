import UIKit
import CoreData

final class DataProvider: NSObject, NSFetchedResultsControllerDelegate {
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
        self.delegate = nil
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.coreDataContainer.viewContext
    }
    
    func updateCollectionView() {
        //Список категорий
        let request = NSFetchRequest<TrackerCategoryCoreData>(entityName: "TrackerCategoryCoreData")
        request.returnsObjectsAsFaults = false
        let trackerCategories = try! context.fetch(request)
        
        //Список ивентов
        let requestTwo = NSFetchRequest<TrackerCoreData>(entityName: "TrackerCoreData")
        requestTwo.returnsObjectsAsFaults = false
        let trackersCD = try! context.fetch(requestTwo)
        trackers = []
        trackerCategories.forEach { category in
            let newCategoryName = category.name
            var events: [Event] = []
            let colorMarshall = UIColorMarshalling()
            trackersCD.forEach { track in
                if track.category?.name == newCategoryName {
                    events.append(Event(name: track.name ?? "", emoji: track.emoji ?? "", color: colorMarshall.color(from: track.color ?? ""), day: track.day?.components(separatedBy: " ")))
                }
            }
            let neeeew = [TrackerCategory(label: newCategoryName ?? "", trackers: events)]
            trackers.append(contentsOf: neeeew)
        }
        delegate?.updateCollection()
    }
    
    func delete(index: IndexPath) {
        print("INDEX", index)
        context.delete(fetchedResultsController.object(at: IndexPath(row: index.row + index.section, section: 0)))
        try! context.save()
        updateCollectionView()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        updateCollectionView()
    }
    
}
