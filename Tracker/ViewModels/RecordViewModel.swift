import Foundation

final class RecordViewModel {
    // MARK: - Свойства
    let model = TrackerRecordStore()
    
    // MARK: - Методы
    /// Метод, добавляющий +1 к счётчику выполненных трекеров
    func addRecord(id: UUID, day: String) {
        model.addRecord(id: id, day: day)
    }
    
    /// Метод, снимающий -1 от счётчика трекеров
    func deleteRecord(id: UUID, day: String) {
        model.deleteRecord(id: id, day: day)
    }
}
