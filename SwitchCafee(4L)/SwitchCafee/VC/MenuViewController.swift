//
//  MenuViewController.swift
//  SwitchCafee
//
//  Created by Евгений Борисов on 18.09.2023.
//

import UIKit

class MenuViewController: UIViewController {

    let titleLabel = UILabel()
    
    let caesarLabel = UILabel()
    let caesarStepper = UIStepper()
    let countCaesarLabel = UILabel()
    
    let cappucinoLabel = UILabel()
    let cappucinoStepper = UIStepper()
    let countCappucinoLabel = UILabel()
    let totalPriceLabel = UILabel()
    var totalPrice: Int {
        Int(caesarStepper.value) * 5 + Int(cappucinoStepper.value) * 2
    }
    let doneButton = UIButton()
    
    weak var delegate: SecondVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let screenWidth = view.frame.width
        let widthItems = Int(screenWidth - 40)
        
        caesarStepper.value = Double(delegate.pickedFood[Food.caesar] ?? 0)
        cappucinoStepper.value = Double(delegate.pickedFood[Food.capuccino] ?? 0)
        
        titleLabel.text = "Menu"
        titleLabel.frame = CGRect(x: 20, y: 80, width: widthItems, height: 30)
        titleLabel.font = titleLabel.font.withSize(26)
        titleLabel.textAlignment = .center
        self.view.addSubview(titleLabel)
        
        caesarLabel.text = "Caesaer salad (5$)"
        caesarLabel.setFontTFLabel()
        caesarLabel.frame = CGRect(x: 20, y: Int(titleLabel.frame.maxY) + 50, width: 200, height: 30)
        
    
        
        countCaesarLabel.text = "\(caesarStepper.value)"
        countCaesarLabel.frame = CGRect(x: caesarLabel.frame.maxX, y: caesarLabel.frame.minY, width: 50, height: 30)
        countCaesarLabel.font = countCaesarLabel.font.withSize(18)
        
        caesarStepper.frame = CGRect(x: countCaesarLabel.frame.maxX, y: caesarLabel.frame.minY, width: 0, height: 0)
        caesarStepper.minimumValue = 0
        
   
        
        caesarStepper.addTarget(self, action: #selector(stepperTapped(sender:)), for: .valueChanged)
        
        self.view.addSubview(caesarLabel)
        self.view.addSubview(countCaesarLabel)
        self.view.addSubview(caesarStepper)
        
        cappucinoLabel.text = "Cappucino (2$)"
        cappucinoLabel.setFontTFLabel()
        cappucinoLabel.frame = CGRect(x: 20, y: Int(countCaesarLabel.frame.maxY) + 30, width: 200, height: 30)
        
        countCappucinoLabel.text = "\(cappucinoStepper.value)"
        countCappucinoLabel.frame = CGRect(x: cappucinoLabel.frame.maxX, y: cappucinoLabel.frame.minY, width: 50, height: 30)
        countCappucinoLabel.font = countCaesarLabel.font.withSize(18)
        
        cappucinoStepper.frame = CGRect(x: countCappucinoLabel.frame.maxX, y: cappucinoLabel.frame.minY, width: 0, height: 0)
        cappucinoStepper.minimumValue = 0
        cappucinoStepper.tag = 1
        cappucinoStepper.addTarget(self, action: #selector(stepperTapped(sender:)), for: .valueChanged)
        
       
        
        self.view.addSubview(cappucinoLabel)
        self.view.addSubview(countCappucinoLabel)
        self.view.addSubview(cappucinoStepper)
        
        doneButton.frame = CGRect(x: 20, y: Int(cappucinoStepper.frame.maxY) + 20, width: widthItems, height: 40)
        doneButton.layer.cornerRadius = 10
        doneButton.backgroundColor = .red
        doneButton.setTitle("Done", for: .normal)
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        self.view.addSubview(doneButton)
        
        totalPriceLabel.font = totalPriceLabel.font.withSize(24)
        totalPriceLabel.text = "Total price: \(totalPrice)$"
        totalPriceLabel.frame = CGRect(x: 20, y: doneButton.frame.maxY + 20, width: 200, height: 50)
        
        self.view.addSubview(totalPriceLabel)
        // Do any additional setup after loading the view.
    }
    
    
    @objc func doneButtonTapped() {
        delegate.totalPriceLabel.text = "Total price: \(totalPrice)$"
        delegate.pickedFood[.caesar] = Int(caesarStepper.value)
        delegate.pickedFood[.capuccino] = Int(cappucinoStepper.value)
        delegate.totalPrice = self.totalPrice
        self.dismiss(animated: true)
        
    }
    
    @objc func stepperTapped(sender: UIStepper) {
        if sender.tag == 0 {
            countCaesarLabel.text = "\(sender.value)"
        } else {
            countCappucinoLabel.text = "\(sender.value)"
        }
        totalPriceLabel.text = "Total price: \(totalPrice)$"
    }
    

   

}
