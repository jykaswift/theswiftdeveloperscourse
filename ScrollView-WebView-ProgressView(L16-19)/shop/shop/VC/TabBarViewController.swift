//
//  TabBarViewController.swift
//  shop
//
//  Created by Евгений Борисов on 31.10.2023.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if StorageManager().bool(forKey: .presentationWasViewed) == nil {
            startPresentation()
        }
    }
    
    private func startPresentation() {
        let presentationController = PageControllerVC(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        presentationController.modalPresentationStyle = .fullScreen
        self.present(presentationController, animated: true)
    }
    
    func setupVC() {
        self.viewControllers = [
            createNavigationCotnrollerWith(rootVC: MainVC(), title: "Купить", image: UIImage(systemName: "macbook.and.iphone")),
            createNavigationCotnrollerWith(rootVC: ForYouVC(), title: "Для вас", image: UIImage(systemName: "person.circle")),
            createNavigationCotnrollerWith(rootVC: MainVC(), title: "Поиск", image: UIImage(systemName: "magnifyingglass")),
            createNavigationCotnrollerWith(rootVC: MainVC(), title: "Корзина", image: UIImage(systemName: "bag"))
        ]
    }
    
    func createNavigationCotnrollerWith(rootVC : UIViewController, title: String, image: UIImage?) -> UINavigationController {
        rootVC.title = title
        let navigationVC = UINavigationController(rootViewController: rootVC)
        navigationVC.tabBarItem.image = image
        navigationVC.tabBarItem.title = title
        
        return navigationVC
    }
    

}

extension UIColor {

   convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1) {

     let redPart: CGFloat = CGFloat(red) / 255
     let greenPart: CGFloat = CGFloat(green) / 255
     let bluePart: CGFloat = CGFloat(blue) / 255

     self.init(red: redPart, green: greenPart, blue: bluePart, alpha: alpha)

   }
}
