import UIKit
import CoreData

/// Класс, работающий с категориями в БД
final class TrackerCategoryStore: NSObject {
    
    // MARK: - Свойства
    /// Переменная, хранящая выбранную пользователем категорию события
    private var categoryName = ""
    
    let appDelegate: AppDelegate
    let context: NSManagedObjectContext
    
    // MARK: - Методы
    override init() {
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.coreDataContainer.viewContext
    }
    
    func changeChoosedCategory(category: String) -> Bool {
        categoryName = category
        return true
    }
    
    func getCategories() -> [String?] {
        let request = NSFetchRequest<CategoriesList>(entityName: "CategoriesList")
        guard let result = try? context.fetch(request) else { return [] }
        let categories = result.map({$0.name})
        return categories
    }
    
    func deleteCategory(at index: IndexPath) -> IndexPath {
        let request = NSFetchRequest<CategoriesList>(entityName: "CategoriesList")
        guard let result = try? context.fetch(request) else { return IndexPath() }
        context.delete(result[index.row])
        do {
            try context.save()
        } catch {
            AlertMessage.shared.displayErrorAlert(title: "Ошибка!", message: "Ошибка удаления категории")
        }
        return index
    }
    
    /// Метод, добавляющий новую категорию в список
    func addCategory(newCategory: String) -> Bool {
        let category = CategoriesList(context: context)
        category.name = newCategory
        do {
            try context.save()
        } catch {
            AlertMessage.shared.displayErrorAlert(title: "Ошибка!", message: "Ошибка добавления категории")
        }
        return true
    }
    
    func getChoosedCategory() -> String {
        return categoryName
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

// MARK: - Расширение для NSFetchedResultsControllerDelegate
extension TrackerCategoryStore: NSFetchedResultsControllerDelegate {
    
    /// Метод, вызываемый автоматически при изменении данных в БД
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        print("1234567890SOS")
    }
    
}
