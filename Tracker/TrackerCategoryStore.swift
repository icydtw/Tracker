import Foundation
import CoreData

/// Класс, работающий с категориями в БД
final class TrackerCategoryStore {
    
    // MARK: - Свойства
    /// Массив с категориями, используемыми в приложении
    
    private var categories = UserDefaults.standard.array(forKey: "category_list") as? [String]

    /// Переменная, хранящая выбранную пользователем категорию события
    private var categoryName = ""
    
    // MARK: - Методы
    func changeChoosedCategory(category: String) -> Bool {
        categoryName = category
        return true
    }
    
    func getCategories() -> [String] {
        return categories ?? []
    }
    
    func deleteCategory(at index: IndexPath) -> IndexPath {
        categories?.remove(at: index.row)
        UserDefaults.standard.set(categories, forKey: "category_list")
        return index
    }
    
    func getChoosedCategory() -> String {
        return categoryName
    }
    
    /// Метод, добавляющий новую категорию в список
    func addCategory(newCategory: String) -> Bool {
        categories?.append(newCategory)
        UserDefaults.standard.set(categories, forKey: "category_list")
        if UserDefaults.standard.synchronize() {
            return true
        } else {
            return false
        }
    }
 
    /// Метод, добавляющий структуру "категория + трекеры" в БД
    func addCategoryStruct(category: String, tracker: TrackerCoreData, context: NSManagedObjectContext) {
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
