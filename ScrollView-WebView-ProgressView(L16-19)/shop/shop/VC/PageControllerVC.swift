//
//  PageControllerVC.swift
//  shop
//
//  Created by Евгений Борисов on 10.11.2023.
//

import UIKit

class PageControllerVC: UIPageViewController {
    
    private lazy var pagesVC = getViewControllers()
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: style, navigationOrientation: navigationOrientation)
        self.setViewControllers([pagesVC[0]], direction: .forward, animated: true)
        self.dataSource = self
        self.view.backgroundColor = .white
        setupPageControl()
        
    }
    
    private func setupPageControl() {
        let proxy = UIPageControl.appearance()
        proxy.pageIndicatorTintColor = .darkGray
        proxy.currentPageIndicatorTintColor = UIColor.black
    }
    
    private func getViewControllers() -> [PageConrainerVC] {
        var viewControllers = [PageConrainerVC]()
        
        viewControllers.append(PageConrainerVC(text: "Приветсвуем в магазине различных товаров", image: UIImage(named: "welcome")!))
        viewControllers.append(PageConrainerVC(text: "Мы предоставляем большой выбор различной техники" , image: UIImage(named: "macbook")!))
        viewControllers.append(PageConrainerVC(text: "Доставка в любую точку страны" , image: UIImage(named: "delivery")!))
        
        return viewControllers
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension PageControllerVC: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? PageConrainerVC, let index = pagesVC.firstIndex(of: vc), index > 0 else {
            return nil
        }
        
        
        let before = index - 1
        return pagesVC[before]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vc = viewController as? PageConrainerVC, let index = pagesVC.firstIndex(of: vc), index < pagesVC.count - 1 else {
            return nil
        }
        let after = index + 1
        return pagesVC[after]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        3
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        0
    }
}
