import UIKit

/// Вью-контроллер таб-бара
final class MainTabBarViewController: UITabBarController {
    
    // MARK: - Метод жизненного цикла viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar() //настраиваем TabBar
    }
    
    // MARK: - Настройка внешнего вида
    private func setupTabBar() {
        view.backgroundColor = .white
        let trackers = TrackersViewController() //первая вкладка "Трекеры"
        trackers.tabBarItem = UITabBarItem(title: "Трекеры", image: UIImage(systemName: "record.circle.fill"), tag: 0)
        let statistics = StatisticsViewController() //вторая вкладка "Статистика"
        statistics.tabBarItem = UITabBarItem(title: "Статистика", image: UIImage(systemName: "hare.fill"), tag: 1)
        viewControllers = [trackers, statistics]
    }
    
}
