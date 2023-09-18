//
//  ThirdVC.swift
//  SwitchCafee
//
//  Created by Евгений Борисов on 18.09.2023.
//

import UIKit

class ThirdVC: UIViewController {
    
    let titleLabel = UILabel()
    var totalCheck = [Food:Int]()
    var totalPrice = 0
    var numberOfTable = ""
    var name = ""
    var numberOfGuests = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let screenWidth = self.view.bounds.maxX
        titleLabel.text = "Information"
        titleLabel.frame = CGRect(x: 0, y: 80, width: screenWidth, height: 30)
        titleLabel.textAlignment = .center
        self.view.addSubview(titleLabel)
        
        let nameLabel = UILabel()
        nameLabel.frame = CGRect(x: 20, y: 120, width: 300, height: 30)
        nameLabel.text = "Name: \(self.name)"
        nameLabel.font = nameLabel.font.withSize(22)
        nameLabel.textColor = .black
        self.view.addSubview(nameLabel)
        
        let tableLabel = UILabel()
        tableLabel.frame = CGRect(x: 20, y: 150, width: 300, height: 30)
        tableLabel.text = "Table №\(self.numberOfTable)"
        tableLabel.font = nameLabel.font.withSize(22)
        tableLabel.textColor = .black
        self.view.addSubview(tableLabel)
        
        let guestLabel = UILabel()
        guestLabel.frame = CGRect(x: 20, y: 180, width: 300, height: 30)
        guestLabel.text = "Number of guests: \(self.numberOfGuests)"
        guestLabel.font = nameLabel.font.withSize(22)
        guestLabel.textColor = .black
        self.view.addSubview(guestLabel)
        let checkView = UIView()
        if totalPrice > 0 {
            checkView.frame = CGRect(x: 20, y: 250, width: Int(screenWidth) - 40, height: (totalCheck.count * 50) + 60)
            checkView.backgroundColor = .black
            
            let checkLabel = UILabel()
            checkLabel.text = "Check"
            checkLabel.textAlignment = .center
            checkLabel.font = checkLabel.font.withSize(26)
            checkLabel.textColor = .white
            checkLabel.frame = CGRect(x: 0, y: 20, width: Int(checkView.frame.width), height: 30)
            checkView.addSubview(checkLabel)
            
            self.view.addSubview(checkView)
            
            var yCounter = 50
            
            for (value, count) in totalCheck {
                if count == 0 { continue }
                let label = UILabel()
                label.text = "\(count) \(value.rawValue)"
                label.font = label.font.withSize(22)
                label.frame = CGRect(x: 20, y: yCounter, width: 200, height: 30)
                label.textColor = .white
                checkView.addSubview(label)
                yCounter += 30
            }
            
            let totalPriceLabel = UILabel()
            totalPriceLabel.text = "Total price \(totalPrice)$"
            totalPriceLabel.frame = CGRect(x: 0, y: checkView.frame.height - 35, width: checkView.frame.width - 20, height: 30)
            totalPriceLabel.font = totalPriceLabel.font.withSize(22)
            totalPriceLabel.textAlignment = .right
            totalPriceLabel.textColor = .white
            checkView.addSubview(totalPriceLabel)
        }
        
        let billButton = UIButton()
        billButton.backgroundColor = .red
        billButton.setTitleColor(.white, for: .normal)
        if totalPrice <= 0 {
            billButton.frame = CGRect(x: 20, y: 250, width: screenWidth - 40, height: 40)
            billButton.setTitle("Bill", for: .normal)
        } else {
            billButton.frame = CGRect(x: 20, y: checkView.frame.maxY + 20, width: screenWidth - 40, height: 40)
            billButton.setTitle("Pay and bill", for: .normal)
        }
        
        billButton.addTarget(self, action: #selector(billButtonTapped), for: .touchUpInside)
        self.view.addSubview(billButton)
        
    
        // Do any additional setup after loading the view.
    }
    
    @objc func billButtonTapped() {
        
        let alert = UIAlertController(title: "Congratulations", message: "you have reserved a table in a restaurant", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
        }
        
        alert.addAction(okAction)
        self.present(alert, animated: true)
        
    }
    
    

}
