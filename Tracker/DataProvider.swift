import UIKit
import CoreData

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
    
    // MARK: - Инициализатор
    override init() {
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.coreDataContainer.viewContext
        self.delegate = nil
    }
    
    // MARK: - Метод, добавляющий в БД новый трекер
    func addTracker(event: Event, category: String) {
        trackerStore.addTracker(event: event, category: category, context: context, trackerCategoryStore: trackerCategoryStore)
    }
    
    // MARK: - Метод, удаляющий трекер из БД
    func deleteTracker(id inID: UUID) {
        trackerStore.deleteTracker(id: inID, context: context)
    }
    
    // MARK: - Метод, добавляющий +1 к счётчику выполненных трекеров
    func addRecord(id: UUID, day: String) {
        trackerRecordStore.addRecord(id: id, day: day, context: context)
    }
    
    // MARK: - Метод, снимающий -1 от счётчика трекеров
    func deleteRecord(id: UUID, day: String) {
        trackerRecordStore.deleteRecord(id: id, day: day, context: context)
    }
    
    // MARK: - Метод, обновляющий массивы, из которых UICollection берёт данные
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
        trackerRecords = []
        let recordRequest = NSFetchRequest<TrackerRecordCoreData>(entityName: "TrackerRecordCoreData")
        recordRequest.returnsObjectsAsFaults = false
        var trackerRecordCD: [TrackerRecordCoreData] = []
        do {
            trackerRecordCD = try context.fetch(recordRequest)
        } catch {
            AlertMessage.shared.displayErrorAlert(title: "Ошибка!", message: "Ошибка получения данных")
        }
        trackerRecordCD.forEach { record in
            trackerRecords.append(TrackerRecord(id: record.tracker?.trackerID ?? UUID(), day: record.day ?? ""))
        }
        delegate?.updateCollection()
    }
    
}

// MARK: - Расширение для NSFetchedResultsControllerDelegate
extension DataProvider: NSFetchedResultsControllerDelegate {
    
    // MARK: Метод, вызываемый автоматически при изменении данных в БД
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        updateCollectionView()
        delegate?.datePickerValueChanged(sender: delegate?.datePicker ?? UIDatePicker())
    }
    
}
