//
//  TabViewController.swift
//  Label
//
//  Created by Евгений Борисов on 09.10.2023.
//

import UIKit

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpControllers()
    }
    
    func setUpControllers() {
        viewControllers = [
            createNavigationVC(rootVC: ViewController(), title: "Testing label", icon: UIImage(systemName: "bubble")!),
            createNavigationVC(rootVC: SecondVC(), title: "Second VC", icon: UIImage(systemName: "figure.walk.diamond")!),
        ]
    }
    
    
    func createNavigationVC(rootVC: UIViewController, title: String, icon: UIImage) -> UINavigationController {
        let navigationVC = UINavigationController(rootViewController: rootVC)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = icon
        rootVC.navigationItem.title = title
        return navigationVC
    }
}
