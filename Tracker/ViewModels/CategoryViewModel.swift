import Foundation

typealias Binding<T> = (T) -> Void

final class CategoryViewModel {
    
    // MARK: - Свойства
    var isCategoryChoosed: Binding<Bool>?
    
    var isCategoryDeleted: Binding<IndexPath>?
    
    var isCategoryAdded: Binding<Bool>?
    
    var model = TrackerCategoryStore()
    
    // MARK: - Методы
    
    func didChooseCategory(name category: String) {
        let result = model.changeChoosedCategory(category: category)
        isCategoryChoosed?(result)
    }
    
    func getCategories() -> [String] {
        return model.getCategories()
    }
    
    func deleteCategory(at index: IndexPath) {
        let result = model.deleteCategory(at: index)
        isCategoryDeleted?(result)
    }
    
    func getChoosedCategory() -> String {
        return model.getChoosedCategory()
    }
    
    func addCategory(newCategory: String) {
        let result = model.addCategory(newCategory: newCategory)
        isCategoryAdded?(result)
    }
}
