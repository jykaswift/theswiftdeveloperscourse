//
//  ItemReviewVC.swift
//  DeviceShop
//
//  Created by Евгений Борисов on 27.09.2023.
//

import UIKit

class ItemReviewVC: UIViewController {
    
    let itemImageView = UIImageView()
    let menuSC = UISegmentedControl()
    let imageSliderButtons = UISegmentedControl()
    let regularFont = "PingFangHK-Regular"
    let boldFont = "PingFangHK-Semibold"
    let nameLabel = UILabel()
    let colorTextField = UITextField()
    let colorLabel = UILabel()
    let nameColors = ["Черный", "Красный", "Синий"]
    let colors: [UIColor] = [.black, .red, .blue]
    let colorPickerView = UIPickerView()
    let addBasketButton = UIButton()
    
    let descriptionLabel = UILabel()
    
    let deliveryLabel = UILabel()
    let deliverySwitch = UISwitch()
    let characteristicsLabel = UILabel()
    
    let countText = UILabel()
    let countSlider = UISlider()
    let countLabel = UILabel()
    
    weak var delegate: ViewController!
    
    var currentItem: ShopItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpView()
    }
    
    func setUpView() {
        self.view.addSubview(colorLabel)
        self.view.addSubview(colorTextField)
        self.view.addSubview(nameLabel)
        self.view.addSubview(itemImageView)
        self.view.addSubview(menuSC)
        self.view.addSubview(countSlider)
        self.view.addSubview(countText)
        self.view.addSubview(countLabel)
        self.view.addSubview(deliveryLabel)
        self.view.addSubview(deliverySwitch)
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(addBasketButton)
        self.view.addSubview(characteristicsLabel)
        
        configureMenu()
        configureImage()
        configureImageSliderButtons()
        configureNameLabel()
        configureDescription()
        configureColorTextField()
        configureCategoryLabel(label: colorLabel, text: "Цвет:")
        configureCategoryLabel(label: countText, text: "Количество:")
        configureCategoryLabel(label: countLabel, text: "1")
        configureCategoryLabel(label: deliveryLabel, text: "Доставка")
        configureCountSlider()
        configureDeliverySwitch()
        configureButton()
        configureCharacteristics()
        setConstraints()
    }
    
    func configureCharacteristics() {
        
        guard let device = currentItem as? Device else { return }
        characteristicsLabel.isHidden = true
        
        let resultString = NSMutableAttributedString()
        
        for (key, value) in device.characteristics {
            let keyAttr = NSMutableAttributedString(string: key + ": ", attributes: [NSAttributedString.Key.font: UIFont(name: boldFont, size: 16)!])
            let valueAttr = NSMutableAttributedString(string: value + "\n", attributes: [NSAttributedString.Key.font: UIFont(name: regularFont, size: 16)!])
            resultString.append(keyAttr)
            resultString.append(valueAttr)
        }

        
        characteristicsLabel.attributedText = resultString
        characteristicsLabel.numberOfLines = 0
        characteristicsLabel.isHidden = true
        
    }
    
    func configureButton() {
        addBasketButton.setTitle(" \(currentItem.price) ₽", for: .normal)
        addBasketButton.setImage(UIImage(systemName: "basket"), for: .normal)
        addBasketButton.tintColor = .white
        addBasketButton.backgroundColor = .black
        addBasketButton.layer.cornerRadius = 12
        
        
        addBasketButton.addTarget(self, action: #selector(addBasketTapped), for: .touchUpInside)
    }
    
     @objc func addBasketTapped(sender: UIButton) {
        
        let count = Int(countSlider.value)
        let totalPrice = count * currentItem.price
        let basketItem = BasketItem(item: currentItem, count: count, totalPrice: totalPrice)
        
        if sender.backgroundColor == .black {
            sender.backgroundColor = .red
            sender.setTitle("Удалить из корзины", for: .normal)
            sender.setImage(UIImage(systemName: "trash.slash"), for: .normal)
            delegate.basket.addItem(item: basketItem)
            
        } else {
            addBasketButton.setTitle(" \(totalPrice) ₽", for: .normal)
            addBasketButton.setImage(UIImage(systemName: "basket"), for: .normal)
            addBasketButton.backgroundColor = .black
            delegate.basket.deleteItem(item: basketItem)
        }
        
    }
    
    func configureDescription() {
        let desctiptionLabel = NSMutableAttributedString(string:"Описание: ", attributes: [NSAttributedString.Key.font: UIFont(name: boldFont, size: 18)!])
        let desctiptionText = NSMutableAttributedString(string:currentItem.description, attributes:[NSAttributedString.Key.font: UIFont(name: regularFont, size: 13)!])
        desctiptionLabel.append(desctiptionText)
        descriptionLabel.attributedText = desctiptionLabel
        descriptionLabel.numberOfLines = 0
        
    }
    
    func configureDeliverySwitch() {
        deliverySwitch.onTintColor = .black
    }
    
    func configureCountSlider() {
        countSlider.minimumTrackTintColor = .black
        countSlider.minimumValue = 1
        countSlider.maximumValue = 10
        
        countSlider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        
    }
    
    @objc func sliderChanged(sender: UISlider) {
        
        let intSliderValue = Int(sender.value)
        countLabel.text = String(intSliderValue)
        
        addBasketButton.setTitle(" \(currentItem.price * intSliderValue) ₽", for: .normal)
        
    }
    
    func configureCategoryLabel(label: UILabel, text: String) {
        label.text = text
        label.font = UIFont(name: boldFont, size: 18)
    }
    
    func configureColorTextField() {
        colorTextField.backgroundColor = .black
        colorTextField.layer.cornerRadius = 10
        colorTextField.layer.masksToBounds = true
        colorTextField.tintColor = .clear
        
        colorPickerView.delegate = self
        colorPickerView.dataSource = self
        colorTextField.inputView = colorPickerView
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.setItems([button], animated: true)

        colorTextField.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonTapped() {
        self.view.endEditing(true)
    }
    
    
    func configureMenu() {
        menuSC.insertSegment(withTitle: "Обзор Товара", at: 0, animated: true)
        menuSC.insertSegment(withTitle: "Характеристики", at: 1, animated: true)
        menuSC.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: regularFont, size: 18)!], for: .normal)
        menuSC.selectedSegmentIndex = 0
        
        menuSC.addTarget(self, action: #selector(menuTapped), for: .valueChanged)
    }
    
    @objc func menuTapped() {
        hideShowReviewOrCharacteristics()
    }
    
    
    func hideShowReviewOrCharacteristics() {
        
        let allitems = [
            colorTextField,
            colorLabel,
            colorPickerView,
            descriptionLabel,
            deliveryLabel,
            deliverySwitch,
            countText,
            countSlider,
            countLabel,
            characteristicsLabel
        ]
        
        allitems.forEach {
            $0.isHidden = !$0.isHidden
        }
        
    }
    
    
    
    func configureImage() {
        itemImageView.image = UIImage(named: currentItem.mainImageName)
        itemImageView.contentMode = .scaleAspectFit
        itemImageView.isUserInteractionEnabled = true
        let swipeLeftGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeImage))
        let swipeRightGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(onSwipeImage))
        swipeLeftGestureRecognizer.direction = .left
        swipeRightGestureRecognizer.direction = .right
        itemImageView.addGestureRecognizer(swipeLeftGestureRecognizer)
        itemImageView.addGestureRecognizer(swipeRightGestureRecognizer)
    }
    
    @objc func onSwipeImage(gester: UISwipeGestureRecognizer) {
        guard let imageNames = currentItem.imagesNames else { return }
        
        var nextIndex = 0
        
        switch gester.direction {
        case .left:
            nextIndex = imageSliderButtons.selectedSegmentIndex + 1
        case .right:
            nextIndex = imageSliderButtons.selectedSegmentIndex - 1
        default:
            return
        }
        
        if !imageNames.indices.contains(nextIndex) { return }
        
        UIView.transition(
            with: itemImageView,
            duration: 0.3,
            options: .transitionFlipFromRight,
            animations: { self.itemImageView.image = UIImage(named: self.currentItem.imagesNames![nextIndex]) }
        )
        
        imageSliderButtons.selectedSegmentIndex = nextIndex
        
    }
    
    func configureImageSliderButtons() {
        guard let imageNames = currentItem.imagesNames else { return }
        
        self.view.addSubview(imageSliderButtons)
        
        for (i, _) in imageNames.enumerated() {
            imageSliderButtons.insertSegment(with: nil, at: i, animated: true)
            imageSliderButtons.setWidth(20, forSegmentAt: i)
        }
        
        imageSliderButtons.selectedSegmentTintColor = .black
        imageSliderButtons.selectedSegmentIndex = 0
        
        imageSliderButtons.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageSliderButtons.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 10),
            imageSliderButtons.centerXAnchor.constraint(equalTo: itemImageView.centerXAnchor),
            imageSliderButtons.heightAnchor.constraint(equalToConstant: 15)
        ])
        
        imageSliderButtons.addTarget(self, action: #selector(onImageSliderChange), for: .valueChanged)
    }
    
    
    @objc func onImageSliderChange() {
        UIView.transition(
            with: itemImageView,
            duration: 0.3,
            options: .transitionFlipFromRight,
            animations: { self.itemImageView.image = UIImage(named: self.currentItem.imagesNames![self.imageSliderButtons.selectedSegmentIndex]) }
        )
    }
    
    func configureNameLabel() {
        nameLabel.text = currentItem.name
        nameLabel.font = UIFont(name: boldFont, size: 20)
        nameLabel.textAlignment = .center
    }
    
    func setConstraints() {
        
        menuSC.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        colorTextField.translatesAutoresizingMaskIntoConstraints = false
        countText.translatesAutoresizingMaskIntoConstraints = false
        countSlider.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        deliveryLabel.translatesAutoresizingMaskIntoConstraints = false
        deliverySwitch.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        addBasketButton.translatesAutoresizingMaskIntoConstraints = false
        characteristicsLabel.translatesAutoresizingMaskIntoConstraints = false
        

        NSLayoutConstraint.activate([
            menuSC.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            menuSC.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            menuSC.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            itemImageView.topAnchor.constraint(equalTo: menuSC.bottomAnchor, constant: 20),
            itemImageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            itemImageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            itemImageView.heightAnchor.constraint(equalToConstant: 250)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 30),
            nameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
        
        
        NSLayoutConstraint.activate([
            colorLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 15),
            colorLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            colorLabel.trailingAnchor.constraint(equalTo: colorTextField.leadingAnchor, constant: -20),
            colorTextField.centerYAnchor.constraint(equalTo: colorLabel.centerYAnchor),
            colorTextField.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            countText.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 15),
            countText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            countText.trailingAnchor.constraint(equalTo: countSlider.leadingAnchor, constant: -20),
            countLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            countLabel.centerYAnchor.constraint(equalTo: countText.centerYAnchor),
            countSlider.centerYAnchor.constraint(equalTo: countText.centerYAnchor),
            countSlider.trailingAnchor.constraint(equalTo: countLabel.leadingAnchor, constant: -20)
            
        ])
        
        NSLayoutConstraint.activate([
            deliveryLabel.topAnchor.constraint(equalTo: countText.bottomAnchor, constant: 15),
            deliveryLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            deliveryLabel.trailingAnchor.constraint(equalTo: deliverySwitch.leadingAnchor, constant: -20),
            deliverySwitch.centerYAnchor.constraint(equalTo: deliveryLabel.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            addBasketButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            addBasketButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            addBasketButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            addBasketButton.heightAnchor.constraint(equalToConstant: 50)
           
        ])
        
        NSLayoutConstraint.activate([
            characteristicsLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
            characteristicsLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            characteristicsLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
        
        
    }
    

}

extension ItemReviewVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return nameColors.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return nameColors[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.colorTextField.backgroundColor = colors[row]
    }
    
}

