//
//  ViewController.swift
//  DeviceShop
//
//  Created by Евгений Борисов on 26.09.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let shopTitle = UILabel()
    var itemViews = [UIView]()
    let regularFont = "PingFangHK-Regular"
    let boldFont = "PingFangHK-Semibold"
    let basketButton = UIButton()
    var deviceController = ShopItemController<Device>()
    var basket = Basket()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var iphone14 = Device(
            name: "IPhone 14 pro",
            price: 40213,
            description: "Смартфон производства корпорации Apple, работающий на базе операционной системы iOS 16 и процессора Apple A15 Bionic. Вычислительный чип которого содержит 16 млрд транзисторов и производится контрактным производителем TSMC по усовершенствованному 4-нанометровому (N4P) техпроцессу."
        )
        
        iphone14.addImageBy(name: "iphone14pro1")
        iphone14.addImageBy(name: "iphone14pro2")
        iphone14.addImageBy(name: "iphone14pro3")
        
        iphone14.characteristics = [
            "Дисплей": "6.1 OLED - 1179 x 2556",
            "Чип": "Apple A16 Bionic",
            "Камера": "4 (48 MP + 12 MP + 12 MP)",
            "OS": "iOS 17",
        ]
        
        var googlePixel6 = Device(
            name: "Google pixel 6",
            price: 35000,
            description: "Google Pixel 6 отличается от других смартфонов новым и уникальным дизайном с двойной камерой, которая значительно улучшает качество снимков и видео. Лицевая панель с ярким AMOLED-экраном обеспечивает яркие и реалистичные цвета. Аккумуляторная емкость 4614 мАч и большой объем хранилища дополнительными преимуществами."
        )
        
        googlePixel6.addImageBy(name: "googlepixel6_1")
        googlePixel6.addImageBy(name: "googlepixel6_2")
        googlePixel6.addImageBy(name: "googlepixel6_3")
        
        googlePixel6.characteristics = [
            "Дисплей": "6.4/1080x2300 Пикс",
            "Чип": "Google Tensor",
            "Камера": "2 (50 MP + 12 MP)",
            "OS": "Android 13",
            "Вес": "207 г."
        ]
        
        deviceController.addItem(item: iphone14)
        deviceController.addItem(item: googlePixel6)
        
        setUpView()
    }
    
    func setUpView() {
        configureShopTitle()
        configureBasketButton()
        for device in deviceController.itemList {
            setItemViewWith(item: device)
        }
        
       
        configureBasketButton()
       
    }
    
    func configureBasketButton() {
        self.view.addSubview(basketButton)
        basketButton.backgroundColor = .black
        basketButton.tintColor = .white
        basketButton.setTitle("Корзина", for: .normal)
        
        basketButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            basketButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            basketButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            basketButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            basketButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        basketButton.addTarget(self, action: #selector(basketButtonTapped), for: .touchUpInside)
    }
    
    @objc func basketButtonTapped() {
        let basketVC = BasketVC()
        basketVC.delegate = self
        
        self.present(basketVC, animated: true)
        
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
    
    func setItemViewWith(item: any ShopItem) {
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
        configureDeviceImageView(deviceImageView, withImageName: item.mainImageName)
        configureDeviceTitle(deviceTitle, withTextTitle: item.name)
        configureDevicePrice(devicePrice, withTextPrice: item.price)
        configureDeviceDescription(deviceDescription, withTextDescription: item.description)
        
        itemViews.append(itemView)

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
        
        if itemViews.isEmpty {
            itemView.topAnchor.constraint(equalTo: shopTitle.bottomAnchor, constant: 30).isActive = true
        } else {
            itemView.topAnchor.constraint(equalTo: itemViews.last!.bottomAnchor, constant: 20).isActive = true
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
        itemView.tag = itemViews.endIndex
        let tapGestureRecongizer = UITapGestureRecognizer(target: self, action: #selector(onItemViewTapped(target:)))
        itemView.addGestureRecognizer(tapGestureRecongizer)
        
    }
    
    @objc func onItemViewTapped(target: UITapGestureRecognizer) {
        guard let tag = target.view?.tag else { return }
        let itemReviwVC = ItemReviewVC()
        let device = deviceController.itemList[tag]
        itemReviwVC.currentItem = device
        itemReviwVC.delegate = self
        
        self.present(itemReviwVC, animated: true)
        
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

