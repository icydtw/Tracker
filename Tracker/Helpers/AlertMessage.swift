import UIKit

/// Класс-окошко с ошибкой
final class AlertMessage {
    
    // MARK: - Свойства
    /// Статическое свойство
    static var shared = AlertMessage()
    
    // MARK: - Методы
    /// Приватный инициализатор
    private init() {}
    
    /// Метод, показывающий окно с ошибкой
    func displayErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        if let viewController = UIApplication.shared.keyWindow?.rootViewController {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
}
