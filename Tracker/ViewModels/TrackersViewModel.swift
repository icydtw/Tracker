import Foundation

final class TrackersViewModel {
    // MARK: - Свойства
    var model = TrackerStore()
    
    // MARK: - Методы
    /// Метод, добавляющий в БД новый трекер
    func addTracker(event: Event, category: String, categoryViewModel: CategoryViewModel) {
        model.addTracker(event: event, category: category, categoryViewModel: categoryViewModel)
    }
    
    /// Метод, удаляющий трекер из БД
    func deleteTracker(id inID: UUID) {
        model.deleteTracker(id: inID)
    }
    
}
