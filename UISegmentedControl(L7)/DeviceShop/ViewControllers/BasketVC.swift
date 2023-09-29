//
//  BasketVC.swift
//  DeviceShop
//
//  Created by Евгений Борисов on 29.09.2023.
//

import UIKit

class BasketVC: UIViewController {
    
    let basketTitle = UILabel()
    weak var delegate: ViewController!
    let itemsStackView = UIStackView()
    let payButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()

    }
    
    func setUpView() {
        view.backgroundColor = .white
        configureBasketTitle()
        configureStackView()
        addBasketItemsView()
        
        if !delegate.basket.itemList.isEmpty {
            configurePayButton()
        }
    }
    
    func configurePayButton() {
        self.view.addSubview(payButton)
        payButton.backgroundColor = .black
        payButton.tintColor = .white
        payButton.setTitle("Оплатить", for: .normal)
        
        payButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            payButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            payButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            payButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            payButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        payButton.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
    }
    
    @objc func payButtonTapped() {
        let alert = UIAlertController(title: "Оплата", message:  "К оплате \(delegate.basket.getTotalPrice()) рублей, желаете оплатить?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Да", style: .default) { _ in
            self.dismiss(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        
        alert.addAction(yesAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
    }
    
    func configureStackView() {
        self.view.addSubview(itemsStackView)
        itemsStackView.axis = .vertical
        itemsStackView.alignment = .fill
        itemsStackView.spacing = 10
        itemsStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemsStackView.topAnchor.constraint(equalTo: basketTitle.bottomAnchor, constant: 20),
            itemsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            itemsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
        ])
        
        
    }
    
    func configureBasketTitle() {
        self.view.addSubview(basketTitle)
        basketTitle.text = "Корзина"
        basketTitle.font = UIFont(name: delegate.boldFont, size: 30)
        
        basketTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            basketTitle.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            basketTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
        
    }
    
    func addBasketItemsView() {
        for item in delegate.basket.itemList {
            
            let label = UILabel()
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = label.font.withSize(18)
            label.heightAnchor.constraint(equalToConstant: 80).isActive = true
            label.numberOfLines = 0
            label.text = "\(item.item.name)\nКоличество: \(item.count)\nЦена: \(item.totalPrice)"
            itemsStackView.addArrangedSubview(label)
            
            
        }
        
        
    }
    


}
