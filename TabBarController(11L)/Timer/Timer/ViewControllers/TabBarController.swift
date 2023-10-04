//
//  TabBarController.swift
//  Timer
//
//  Created by Евгений Борисов on 03.10.2023.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
        setUpVC()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    func configureTabBar() {
        // Цвет элементов таб бара
        tabBar.tintColor = .orange
        tabBar.unselectedItemTintColor = .lightGray
        
        // Установка размера шрифта элементов
        let systemFontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0)]
        UITabBarItem.appearance().setTitleTextAttributes(systemFontAttributes, for: .normal)
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 5)
    }
    
    func setUpVC() {
        viewControllers = [
            createVC(WorldClockVC(), withTitle: "World Clock", withImage: UIImage(systemName: "network")!),
            createVC(AlarmVC(), withTitle: "Alarm", withImage: UIImage(systemName: "alarm.fill")!),
            createVC(StopwatchVC(), withTitle: "Stopwatch", withImage: UIImage(systemName: "stopwatch.fill")!),
            createVC(TimerVC(), withTitle: "Timer", withImage: UIImage(systemName: "timer")!),
        ]
    }
    
    func createVC(_ viewController: UIViewController, withTitle title: String, withImage image: UIImage) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    



}
