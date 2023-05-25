import Foundation

typealias Binding<T> = (T) -> Void

final class CategoryViewModel {
    
    // MARK: - Свойства
    static var shared = CategoryViewModel()
    
    var isCategoryChoosed: Binding<Bool>?
    
    var isCategoryDeleted: Binding<IndexPath>?
    
    var model = TrackerCategoryStore()
    
    // MARK: - Методы
    private init() {}
    
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
}
