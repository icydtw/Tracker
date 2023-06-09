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
        tabBar.backgroundColor = UIColor(named: "WhiteToBlack")
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let trackers = TrackersViewController(trackersViewModel: appDelegate?.trackersViewModel ?? TrackersViewModel(), recordViewModel: appDelegate?.recordViewModel ?? RecordViewModel(), categoryViewModel: appDelegate?.categoryViewModel ?? CategoryViewModel()) //первая вкладка "Трекеры"
        trackers.tabBarItem = UITabBarItem(title: NSLocalizedString("TrackersViewController.title", comment: ""), image: UIImage(systemName: "record.circle.fill"), tag: 0)
        let statistics = StatisticsViewController(statisticsViewModel: appDelegate?.statisticsViewModel ?? StatisticsViewModel()) //вторая вкладка "Статистика"
        statistics.tabBarItem = UITabBarItem(title: NSLocalizedString("StatisticsViewController.title", comment: ""), image: UIImage(systemName: "hare.fill"), tag: 1)
        viewControllers = [trackers, statistics]
    }
    
    /// Настройка свойств
    private func setupProperties() {
        UserDefaults.standard.set(true, forKey: "isLogged")
    }
    
}
