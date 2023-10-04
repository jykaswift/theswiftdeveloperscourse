//
//  ViewController.swift
//  Timer
//
//  Created by Евгений Борисов on 03.10.2023.
//

import UIKit

class WorldClockVC: UIViewController {
    
    var editButton = UIButton()
    var plusButton = UIButton()
    var worldClockLabel = UILabel()
    var timesList = [UIStackView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
  
    
    func setUpView() {
        configureUI()
        configureLayout()
    }
    
    func configureUI() {
        configureEditButton()
        configurePlusButton()
        configureWorldClockLabel()
    }
    
    func configureWorldClockLabel() {
        worldClockLabel.disableAutoresizingMask()
        worldClockLabel.text = "World Clock"
        worldClockLabel.textColor = .white
        worldClockLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        
    }
    
    func configurePlusButton() {
        plusButton.disableAutoresizingMask()
        plusButton.setBackgroundImage(UIImage(systemName: "plus"), for: .normal)
        plusButton.tintColor = .orange
        
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        
    }
    
    @objc func plusButtonTapped() {
        let cityPickerVC = CityPickerVC()
        cityPickerVC.modalPresentationStyle = .popover
        cityPickerVC.delegate = self
        self.present(cityPickerVC, animated: true)
    }
    
    func configureEditButton() {
        editButton.disableAutoresizingMask()
        editButton.tintColor = .systemOrange
        editButton.setTitleColor(.orange, for: .normal)
        editButton.setTitleColor(.systemBrown, for: .highlighted)
        editButton.setTitle("Edit", for: .normal)
        editButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
    }
    
    func configureLayout() {
        view.addSubview(editButton)
        view.addSubview(plusButton)
        view.addSubview(worldClockLabel)
        
        
        // MARK: Configure TOP Buttons
        NSLayoutConstraint.activate([
            editButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
            editButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            plusButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: plusButton.trailingAnchor, multiplier: 1),
            plusButton.heightAnchor.constraint(equalTo: editButton.heightAnchor, multiplier: 0.8),
            plusButton.widthAnchor.constraint(equalTo: plusButton.heightAnchor, multiplier: 1),
        ])
        
        NSLayoutConstraint.activate([
            worldClockLabel.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 15),
            worldClockLabel.leadingAnchor.constraint(equalTo: editButton.leadingAnchor)
        ])
    }
    
    func addNewWorldTimeWith(city: String, andDay day: String, andTimeDifference timeDifference: String, andCurrentTime currentTime: String) {
        let worldTimeContainer = UIStackView()
        view.addSubview(worldTimeContainer)
        worldTimeContainer.axis = .horizontal
        worldTimeContainer.alignment = .center
        worldTimeContainer.distribution = .equalSpacing
        
        
        let cityDifferenceContainer = UIStackView()
        cityDifferenceContainer.axis = .vertical
        
        let differenceLabel = UILabel()
        differenceLabel.text = "\(day), \(timeDifference)HRS"
        differenceLabel.textColor = .lightGray
        differenceLabel.font = UIFont.systemFont(ofSize: 18)
        
        let cityLabel = UILabel()
        cityLabel.text = city
        cityLabel.textColor = .white
        cityLabel.font = UIFont.systemFont(ofSize: 32)
        
        let timeLabel = UILabel()
        timeLabel.text = currentTime
        timeLabel.textColor = .white
        timeLabel.font = UIFont.systemFont(ofSize: 48)
        
        cityDifferenceContainer.addArrangedSubview(differenceLabel)
        cityDifferenceContainer.addArrangedSubview(cityLabel)
        worldTimeContainer.addArrangedSubview(cityDifferenceContainer)
        worldTimeContainer.addArrangedSubview(timeLabel)
        
        worldTimeContainer.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            worldTimeContainer.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: worldTimeContainer.trailingAnchor, multiplier: 1),
        ])
        
        if timesList.isEmpty {
            worldTimeContainer.topAnchor.constraint(equalTo: worldClockLabel.bottomAnchor, constant: 30).isActive = true
        } else {
            worldTimeContainer.topAnchor.constraint(equalTo: timesList.last!.bottomAnchor, constant: 30).isActive = true
        }
        
        worldTimeContainer.addBottomBorder()
        timesList.append(worldTimeContainer)
        
        
    }


}

extension UIView {
    func disableAutoresizingMask() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addBottomBorder() {
        let bottomBorder = UIView()
        self.addSubview(bottomBorder)
        bottomBorder.disableAutoresizingMask()
        bottomBorder.backgroundColor = .white
        bottomBorder.alpha = 0.8
        
        NSLayoutConstraint.activate([
            bottomBorder.heightAnchor.constraint(equalToConstant: 1),
            bottomBorder.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomBorder.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 10)
        ])
        
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, a: Int = 0xFF) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: CGFloat(a) / 255.0
        )
    }
}
