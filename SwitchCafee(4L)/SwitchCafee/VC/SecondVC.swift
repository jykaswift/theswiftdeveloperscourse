//
//  SecondVC.swift
//  SwitchCafee
//
//  Created by Евгений Борисов on 17.09.2023.
//

import UIKit

class SecondVC: UIViewController {
    
    let titleLabel = UILabel()
    let nameLabel = UILabel()
    let guestLabel = UILabel()
    let numberTableLabel = UILabel()
    let nameTF = UITextField()
    let guestTf = UITextField()
    let numberTableTF = UITextField()
    
    weak var delegate: ViewController!
    
    let bookLabel = UILabel()
    let bookSwitch = UISwitch()

    let prepaymentLabel = UILabel()
    let prepaymentSwitch = UISwitch()
    
    let VIPLabel = UILabel()
    let VIPSwitch = UISwitch()
    
    let endButton = UIButton()
    
    let totalPriceLabel = UILabel()
    let menuButton = UIButton()
    
    
    var pickedFood = [Food:Int]()
    
    var totalPrice = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let screenWidth = view.frame.width
        let widthItems = Int(screenWidth - 40)
        
        titleLabel.text = "Cafe Swift"
        titleLabel.font = titleLabel.font.withSize(26)
        titleLabel.textAlignment = .center
        titleLabel.frame = CGRect(x: 20, y: 80, width: widthItems, height: 40)
        self.view.addSubview(titleLabel)
        
        nameLabel.text = "Name"
        nameLabel.frame = CGRect(x: 20, y: 150, width: widthItems, height: 30)
        nameLabel.setFontTFLabel()
        
        nameTF.placeholder = "Enter name"
        nameTF.frame = CGRect(x: 20, y: Int(nameLabel.frame.maxY + 5), width: widthItems, height: 30)
        nameTF.setUnderLine()
        
        self.view.addSubview(nameLabel)
        self.view.addSubview(nameTF)
        
        guestLabel.text = "Number of guests"
        guestLabel.frame = CGRect(x: 20, y: Int(nameTF.frame.maxY + 30), width: widthItems, height: 30)
        guestLabel.setFontTFLabel()
        
        guestTf.placeholder = "Enter a number"
        guestTf.frame = CGRect(x: 20, y: Int(guestLabel.frame.maxY + 5), width: widthItems, height: 30)
        guestTf.setUnderLine()
        
        self.view.addSubview(guestLabel)
        self.view.addSubview(guestTf)
        
        
        numberTableLabel.text = "Number of table"
        numberTableLabel.frame = CGRect(x: 20, y: Int(guestTf.frame.maxY + 30), width: widthItems, height: 30)
        numberTableLabel.setFontTFLabel()
        
        numberTableTF.placeholder = "Enter a number of table"
        numberTableTF.frame = CGRect(x: 20, y: Int(numberTableLabel.frame.maxY + 5), width: widthItems, height: 30)
        numberTableTF.setUnderLine()
        
        self.view.addSubview(numberTableLabel)
        self.view.addSubview(numberTableTF)
        
        bookLabel.text = "Book a table"
        bookLabel.setFontTFLabel()
        bookLabel.frame = CGRect(x: 20, y: Int(numberTableTF.frame.maxY + 40), width: Int(Double(widthItems) * 0.75), height: 30)
        
        bookSwitch.frame = CGRect(x: Int(bookLabel.frame.maxX) + 20, y: Int(numberTableTF.frame.maxY + 40), width: 0, height: 0)
        bookSwitch.isOn = true
        self.view.addSubview(bookLabel)
        self.view.addSubview(bookSwitch)
        
        prepaymentLabel.text = "Prepayment"
        prepaymentLabel.setFontTFLabel()
        prepaymentLabel.frame = CGRect(x: 20, y: Int(bookLabel.frame.maxY + 40), width: Int(Double(widthItems) * 0.75), height: 30)
        
        prepaymentSwitch.frame = CGRect(x: Int(prepaymentLabel.frame.maxX) + 20, y: Int(bookLabel.frame.maxY + 40), width: 0, height: 0)
        
        prepaymentSwitch.addTarget(self, action: #selector(prepaymentChanged(target:)), for: .valueChanged)
        
        self.view.addSubview(prepaymentLabel)
        self.view.addSubview(prepaymentSwitch)
        
        VIPLabel.text = "VIP Room"
        VIPLabel.setFontTFLabel()
        VIPLabel.frame = CGRect(x: 20, y: Int(prepaymentLabel.frame.maxY + 40), width: Int(Double(widthItems) * 0.75), height: 30)
        
        VIPSwitch.frame = CGRect(x: Int(VIPLabel.frame.maxX) + 20, y: Int(prepaymentSwitch.frame.maxY + 40), width: 0, height: 0)
        
        self.view.addSubview(VIPLabel)
        self.view.addSubview(VIPSwitch)
        
        endButton.frame = CGRect(x: 20, y: Int(VIPSwitch.frame.maxY) + 50, width: widthItems, height: 40)
        endButton.backgroundColor = .red
        endButton.setTitle("Bill", for: .normal)
        endButton.titleLabel?.textColor = .red
        endButton.layer.cornerRadius = 10
        
        endButton.addTarget(self, action: #selector(billButtonTapped), for: .touchUpInside)
        
        self.view.addSubview(endButton)
        
        totalPriceLabel.text = "Total price: 0$"
        totalPriceLabel.frame = CGRect(x: 20, y: endButton.frame.maxY + 20, width: 150, height: 25)
        
        menuButton.setTitle("Menu", for: .normal)
        
        menuButton.frame = CGRect(x: totalPriceLabel.frame.maxX, y: totalPriceLabel.frame.minY - 5, width: 100, height: 40)
        menuButton.backgroundColor = .white
        menuButton.setTitleColor(.blue, for: .normal)
        
        totalPriceLabel.isHidden = true
        menuButton.isHidden = true
        
        menuButton.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
        self.view.addSubview(totalPriceLabel)
        self.view.addSubview(menuButton)
    }
    
    @objc func menuButtonTapped() {
        
        let vc = MenuViewController()
        vc.delegate = self
        self.present(vc, animated: true)
        
    }
    
    @objc func prepaymentChanged(target: UISwitch) {
        if target.isOn {
            let menuVC = MenuViewController()
            menuVC.modalPresentationStyle = .fullScreen
            menuVC.delegate = self
            totalPriceLabel.isHidden = false
            menuButton.isHidden = false
            self.present(menuVC, animated: true)
        } else {
            totalPriceLabel.isHidden = true
            menuButton.isHidden = true
            totalPrice = 0
        }
    }
    
    @objc func billButtonTapped() {
        
        let alert = UIAlertController(title: "Bill?", message: nil, preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "OK", style: .default) {_ in
            let thirdVC = ThirdVC()
            thirdVC.totalCheck = self.pickedFood
            thirdVC.totalPrice = self.totalPrice
            thirdVC.numberOfTable = self.numberTableTF.text ?? ""
            thirdVC.numberOfGuests = self.guestTf.text ?? ""
            thirdVC.name = self.nameTF.text ?? ""
            self.present(thirdVC, animated: true)
        }
        let actionCancel = UIAlertAction(title: "cancel", style: .default)
        alert.addAction(actionOK)
        alert.addAction(actionCancel)
        
        self.present(alert, animated: true)
        
        
        
    }
    
  
}
