import UIKit

/// Класс первого онбординг-экрана
final class FirstOnboardingPageViewController: UIViewController {
    
    // MARK: - Свойства
    lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "FirstOnboardPageImage")
        imageView.frame = view.bounds
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - Методы
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProperties()
        setupView()
    }
    
    /// Настройка внешнего вида
    private func setupView() {
        view.backgroundColor = .brown
    }
    
    /// Настройка свойств
    private func setupProperties() {
        view.addSubview(backgroundImage)
    }
    
}