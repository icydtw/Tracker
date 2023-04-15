//
//  MainTabBarViewController.swift
//  Tracker
//
//  Created by Илья Тимченко on 15.04.2023.
//

import UIKit

final class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar() //настраиваем TabBar
    }
    
}

extension MainTabBarViewController {
    
    private func setupTabBar() {
        view.backgroundColor = .white
        
        let trackers = TrackersViewController() //первая вкладка "Трекеры"
        trackers.tabBarItem = UITabBarItem(title: "Трекеры", image: UIImage(systemName: "record.circle.fill"), tag: 0)
        
        let statistics = StatisticsViewController() //вторая вкладка "Статистика"
        statistics.tabBarItem = UITabBarItem(title: "Статистика", image: UIImage(systemName: "hare.fill"), tag: 1)
        
        viewControllers = [trackers, statistics]
    }
    
}
