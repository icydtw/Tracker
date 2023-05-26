import UIKit

/// Вью-контроллер таб-бара
final class MainTabBarViewController: UITabBarController {
    
    /// Инициализатор
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupTabBar()
        setupProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Настройка внешнего вида
    private func setupTabBar() {
        tabBar.backgroundColor = .white
        let trackers = TrackersViewController() //первая вкладка "Трекеры"
        trackers.tabBarItem = UITabBarItem(title: "Трекеры", image: UIImage(systemName: "record.circle.fill"), tag: 0)
        let statistics = StatisticsViewController() //вторая вкладка "Статистика"
        statistics.tabBarItem = UITabBarItem(title: "Статистика", image: UIImage(systemName: "hare.fill"), tag: 1)
        viewControllers = [trackers, statistics]
    }
    
    /// Настройка свойств
    private func setupProperties() {
        UserDefaults.standard.set(true, forKey: "isLogged")
        let categoryList = UserDefaults.standard.array(forKey: "category_list") as? [String]
        if categoryList == nil || categoryList == [] {
            UserDefaults.standard.set([
                "Домашние дела", "Хобби", "Работа", "Учёба", "Спорт"
            ], forKey: "category_list")
        }
    }
    
}
