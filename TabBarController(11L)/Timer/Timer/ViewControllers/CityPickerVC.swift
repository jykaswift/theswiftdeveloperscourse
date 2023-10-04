//
//  CityPickerVC.swift
//  Timer
//
//  Created by Евгений Борисов on 03.10.2023.
//

import UIKit

class CityPickerVC: UIViewController {
    
    let choseCityLabel = UILabel()
    
    weak var delegate: WorldClockVC!
    
    var dateController = DateController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView() {
        configureUI()
        configureLayout()
        setCities()
    }
    
    func setCities() {
        
        var topDistanceCounter: CGFloat = 40
        
        for (city, timezone) in dateController.citiesAndTimezones.sorted(by: { $0.key > $1.key }) {
            let cityLabel = UILabel()
            self.view.addSubview(cityLabel)
            cityLabel.accessibilityIdentifier = timezone
            cityLabel.disableAutoresizingMask()
            cityLabel.text = city
            cityLabel.font = UIFont.systemFont(ofSize: 18)
            cityLabel.textColor = .white
            cityLabel.isUserInteractionEnabled = true
            cityLabel.addBottomBorder()
            
            NSLayoutConstraint.activate([
                cityLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
                view.trailingAnchor.constraint(equalToSystemSpacingAfter: cityLabel.trailingAnchor, multiplier: 1),
                cityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topDistanceCounter)
            ])
            
            topDistanceCounter += 40
            
            
            let labelTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onCityLabelTapped(recognizer:)))
            cityLabel.addGestureRecognizer(labelTapRecognizer)
            
        }
        
    }
    
    @objc func onCityLabelTapped(recognizer: UITapGestureRecognizer) {
        guard let labelIdentifier = recognizer.view?.accessibilityIdentifier else { return }
        
        let currentTimeZoneTime = dateController.getCurrentTimeOfTimezoneWith(identifier: labelIdentifier)
        let timeDifference = dateController.getTimeDifferenceWith(anotherTimeZoneIdentifier: labelIdentifier)
        let dayDifference = dateController.calculateDayDifferenceWith(currentTime: currentTimeZoneTime, andTimeDifference: timeDifference)
        let startIndexCity = labelIdentifier.index(after: labelIdentifier.firstIndex(of: "/")!)
        let city = String(labelIdentifier[startIndexCity...])
        
        delegate.addNewWorldTimeWith(city: city, andDay: dayDifference, andTimeDifference: timeDifference, andCurrentTime: currentTimeZoneTime)
        
        self.dismiss(animated: true)
    }
    
    
    
    func configureUI() {
        self.view.backgroundColor = UIColor(red: 20, green: 20, blue: 20)
        choseCityLabel.disableAutoresizingMask()
        choseCityLabel.text = "Choose a City"
        choseCityLabel.textColor = .white
        choseCityLabel.font = UIFont.systemFont(ofSize: 16)
    }

    
    func configureLayout() {
        view.addSubview(choseCityLabel)
        
        NSLayoutConstraint.activate([
            choseCityLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            choseCityLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1)
        ])
    }
    


}
