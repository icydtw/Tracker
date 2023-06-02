import Foundation

final class TrackersViewModel {
    // MARK: - Свойства
    var model = TrackerStore()
    
    var isTrackerAdded: Binding<Bool>?
    
    var isTrackerDeleted: Binding<Bool>?
    
    // MARK: - Методы
    /// Метод, добавляющий в БД новый трекер
    func addTracker(event: Event, category: String, categoryViewModel: CategoryViewModel) {
        let result = model.addTracker(event: event, category: category, categoryViewModel: categoryViewModel)
        isTrackerAdded?(result)
    }
    
    /// Метод, удаляющий трекер из БД
    func deleteTracker(id inID: UUID) {
        let result = model.deleteTracker(id: inID)
        isTrackerDeleted?(result)
    }
    
    /// Метод, "закрепляющий" трекер
    func pinEvent(oldCategory: String, eventToPin: Event, categoryViewModel: CategoryViewModel) {
        deleteTracker(id: eventToPin.id)
        addTracker(event: eventToPin, category: NSLocalizedString("TrackersViewController.pinned", comment: "Закреплённые"), categoryViewModel: categoryViewModel)
        model.pinEvent(oldCategory: oldCategory, id: eventToPin.id)
    }
    
    /// Метод, "открепляющий" трекер
    func unpinEvent(eventToUnpin: Event, categoryViewModel: CategoryViewModel) {
        deleteTracker(id: eventToUnpin.id)
        let oldCategory = model.unpinEvent(id: eventToUnpin.id)
        addTracker(event: eventToUnpin, category: oldCategory, categoryViewModel: categoryViewModel)
    }
    
}
