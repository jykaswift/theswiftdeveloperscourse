//
//  ViewController.swift
//  DeviceShop
//
//  Created by Евгений Борисов on 26.09.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let shopTitle = UILabel()
    let deviceViews = [UIView]()
    let regularFont = "PingFangHK-Regular"
    let boldFont = "PingFangHK-Semibold"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView() {
        configureShopTitle()
        setItemView()
        
    }
    
    func configureShopTitle() {
        self.view.addSubview(shopTitle)
        shopTitle.text = "Device Shop"
        shopTitle.font = UIFont(name: boldFont, size: 30)
        
        shopTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            shopTitle.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            shopTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
        
    }
    
    func setItemView() {
        let itemView = UIView()
        let deviceImageView = UIImageView()
        let deviceTitle = UILabel()
        let devicePrice = UILabel()
        let deviceDescription = UILabel()
        
        self.view.addSubview(itemView)
        itemView.addSubview(deviceImageView)
        itemView.addSubview(deviceTitle)
        itemView.addSubview(devicePrice)
        itemView.addSubview(deviceDescription)
        
        setConstraintsItemViewWith(
            itemView: itemView,
            deviceImageView: deviceImageView,
            deviceTitle: deviceTitle,
            devicePrice: devicePrice,
            deviceDescription: deviceDescription
        )
        
        configureItemView(itemView)
        configureDeviceImageView(deviceImageView, withImageName: "iphone14pro")
        configureDeviceTitle(deviceTitle, withTextTitle: "IPhone 14 pro")
        configureDevicePrice(devicePrice, withTextPrice: 40321)
        configureDeviceDescription(deviceDescription, withTextDescription: "У iPhone 14 Pro 6,1--дюймовая панель. Пиковая яркость — 2000 нит. Используется небольшой вырез с датчиком фронтальной камеры и системой Face ID.")

    }
    
    
    func setConstraintsItemViewWith(
        itemView: UIView,
        deviceImageView: UIImageView,
        deviceTitle: UILabel,
        devicePrice: UILabel,
        deviceDescription: UILabel
    ) {
        
        itemView.translatesAutoresizingMaskIntoConstraints = false
        deviceImageView.translatesAutoresizingMaskIntoConstraints = false
        deviceTitle.translatesAutoresizingMaskIntoConstraints = false
        devicePrice.translatesAutoresizingMaskIntoConstraints = false
        deviceDescription.translatesAutoresizingMaskIntoConstraints = false
   
        // MARK: Device View Constraints
        NSLayoutConstraint.activate([
            itemView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            itemView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            itemView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        if deviceViews.isEmpty {
            itemView.topAnchor.constraint(equalTo: shopTitle.bottomAnchor, constant: 30).isActive = true
        } else {
            itemView.topAnchor.constraint(equalTo: deviceViews.last!.bottomAnchor, constant: 20).isActive = true
        }
        
        // MARK: Device Image Constraints
        
        NSLayoutConstraint.activate([
            deviceImageView.leadingAnchor.constraint(equalTo: itemView.leadingAnchor, constant: 0),
            deviceImageView.topAnchor.constraint(equalTo: itemView.topAnchor, constant: 0),
            deviceImageView.heightAnchor.constraint(equalTo: itemView.heightAnchor, multiplier: 1),
            deviceImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        // MARK: Device Title Constraints
        
        NSLayoutConstraint.activate([
            deviceTitle.leadingAnchor.constraint(equalTo: deviceImageView.trailingAnchor, constant: 5),
            deviceTitle.trailingAnchor.constraint(equalTo: itemView.trailingAnchor, constant: -20),
            deviceTitle.topAnchor.constraint(equalTo: itemView.topAnchor, constant: 0),
        ])
        
        // MARK: Device Price Constraints
        
        NSLayoutConstraint.activate([
            devicePrice.leadingAnchor.constraint(equalTo: deviceImageView.trailingAnchor, constant: 5),
            devicePrice.trailingAnchor.constraint(equalTo: itemView.trailingAnchor, constant: -20),
            devicePrice.topAnchor.constraint(equalTo: deviceTitle.bottomAnchor, constant: -5),
        ])
        
        // MARK: Device Description Constraints
        
        NSLayoutConstraint.activate([
            deviceDescription.leadingAnchor.constraint(equalTo: deviceImageView.trailingAnchor, constant: 5),
            deviceDescription.trailingAnchor.constraint(equalTo: itemView.trailingAnchor, constant: -20),
            deviceDescription.topAnchor.constraint(equalTo: devicePrice.bottomAnchor, constant: 0),
            deviceDescription.bottomAnchor.constraint(equalTo: itemView.bottomAnchor, constant: 0)
        ])
    }
    
    func configureItemView(_ itemView: UIView) {

       
        
    }
    
    func configureDeviceImageView(_ deviceImageView: UIImageView, withImageName imageName: String) {
        deviceImageView.image = UIImage(named: imageName)
    }
    
    func configureDeviceTitle(_ deviceTitle: UILabel, withTextTitle text: String) {
        deviceTitle.text = text
        deviceTitle.font = UIFont(name: regularFont, size: 22)
    }
    
    func configureDevicePrice(_ devicePrice: UILabel, withTextPrice price: Int) {
        devicePrice.text = "\(price) rub"
        devicePrice.font = UIFont(name: boldFont, size: 22)
    }
    
    func configureDeviceDescription(_ deviceDescription: UILabel, withTextDescription description: String) {
        deviceDescription.text = description
        deviceDescription.font = UIFont(name: regularFont, size: 14)
        deviceDescription.numberOfLines = 0
    }
    
    
    
    


}

