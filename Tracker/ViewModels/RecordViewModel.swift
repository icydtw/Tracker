import Foundation

final class RecordViewModel {
    // MARK: - Свойства
    let model = TrackerRecordStore()
    
    var isRecordAdded: Binding<Bool>?
    
    var isRecordDeleted: Binding<Bool>?
    
    // MARK: - Методы
    /// Метод, добавляющий +1 к счётчику выполненных трекеров
    func addRecord(id: UUID, day: String) {
        let result = model.addRecord(id: id, day: day)
        isRecordAdded?(result)
    }
    
    /// Метод, снимающий -1 от счётчика трекеров
    func deleteRecord(id: UUID, day: String) {
        let result = model.deleteRecord(id: id, day: day)
        isRecordDeleted?(result)
    }
}
