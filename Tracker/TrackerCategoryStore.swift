import Foundation
import CoreData

/// Класс, работающий с категориями в БД
final class TrackerCategoryStore {
    
    // MARK: - Свойства
    /// Массив с категориями, используемыми в приложении
    private var categories = [
        "Домашние дела", "Хобби", "Работа", "Учёба", "Спорт"
    ]

    /// Переменная, хранящая выбранную пользователем категорию события
    private var categoryName = ""
    
    // MARK: - Методы
    func changeChoosedCategory(category: String) -> Bool {
        categoryName = category
        return true
    }
    
    func getCategories() -> [String] {
        return categories
    }
    
    func deleteCategory(at index: IndexPath) -> IndexPath {
        categories.remove(at: index.row)
        return index
    }
    
    func getChoosedCategory() -> String {
        return categoryName
    }
 
    /// Метод, добавляющий категорию в БД
    func addCategory(category: String, tracker: TrackerCoreData, context: NSManagedObjectContext) {
        let request = NSFetchRequest<TrackerCategoryCoreData>(entityName: "TrackerCategoryCoreData")
        request.returnsObjectsAsFaults = false
        var trackerCategories: [TrackerCategoryCoreData] = []
        do {
            trackerCategories = try context.fetch(request)
        } catch {
            AlertMessage.shared.displayErrorAlert(title: "Ошибка!", message: "Ошибка получения данных")
        }
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
        do {
            try context.save()
        } catch {
            AlertMessage.shared.displayErrorAlert(title: "Ошибка!", message: "Ошибка сохранения данных")
        }
    }
    
}
