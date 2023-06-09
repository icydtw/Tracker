import UIKit
import CoreData

/// Класс-источник данных, работающий с Core Data
final class DataProvider: NSObject {
    
    // MARK: - Свойства
    let appDelegate: AppDelegate
    
    let context: NSManagedObjectContext
    
    weak var delegate: TrackersViewController?
    
    let trackerStore = TrackerStore()
    
    let trackerCategoryStore = TrackerCategoryStore()
    
    let trackerRecordStore = TrackerRecordStore()
    
    lazy var fetchedResultsController: NSFetchedResultsController<TrackerCoreData> = {
        let request = NSFetchRequest<TrackerCoreData>(entityName: "TrackerCoreData")
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let controller = NSFetchedResultsController<TrackerCoreData>(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        try? controller.performFetch()
        return controller
    }()
    
    // MARK: - Методы
    /// Инициализатор
    override init() {
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.context
        self.delegate = nil
    }
    
    /// Метод, обновляющий массивы, из которых UICollection берёт данные
    func updateCollectionView() {
        let categoryRequest = NSFetchRequest<TrackerCategoryCoreData>(entityName: "TrackerCategoryCoreData")
        categoryRequest.returnsObjectsAsFaults = false
        var trackerCategories: [TrackerCategoryCoreData] = []
        do {
            trackerCategories = try context.fetch(categoryRequest)
        } catch {
            AlertMessage.shared.displayErrorAlert(title: "Ошибка!", message: "Ошибка получения данных")
        }
        let trackerRequest = NSFetchRequest<TrackerCoreData>(entityName: "TrackerCoreData")
        trackerRequest.returnsObjectsAsFaults = false
        var trackersCD: [TrackerCoreData] = []
        do {
            trackersCD = try context.fetch(trackerRequest)
        } catch {
            AlertMessage.shared.displayErrorAlert(title: "Ошибка!", message: "Ошибка получения данных")
        }
        delegate?.trackers = []
        trackerCategories.forEach { category in
            let newCategoryName = category.name
            var events: [Event] = []
            trackersCD.forEach { track in
                if track.category?.name == newCategoryName {
                    events.append(Event(id: track.trackerID ?? UUID(), name: track.name ?? "", emoji: track.emoji ?? "", color: UIColor.color(from: track.color ?? ""), day: track.day?.components(separatedBy: " ")))
                }
            }
            let neeeew = [TrackerCategory(label: newCategoryName ?? "", trackers: events)]
            delegate?.trackers.append(contentsOf: neeeew.sorted(by: {$0.label > $1.label}))
        }
        delegate?.trackerRecords = []
        let recordRequest = NSFetchRequest<TrackerRecordCoreData>(entityName: "TrackerRecordCoreData")
        recordRequest.returnsObjectsAsFaults = false
        var trackerRecordCD: [TrackerRecordCoreData] = []
        do {
            trackerRecordCD = try context.fetch(recordRequest)
        } catch {
            AlertMessage.shared.displayErrorAlert(title: "Ошибка!", message: "Ошибка получения данных")
        }
        trackerRecordCD.forEach { record in
            delegate?.trackerRecords.append(TrackerRecord(id: record.tracker?.trackerID ?? UUID(), day: record.day ?? ""))
        }
        delegate?.updateCollection()
    }
    
}

// MARK: - Расширение для NSFetchedResultsControllerDelegate
extension DataProvider: NSFetchedResultsControllerDelegate {
    
    /// Метод, вызываемый автоматически при изменении данных в БД
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        updateCollectionView()
        delegate?.dataChanged(sender: delegate?.datePicker ?? UIDatePicker())
    }
    
}
