//
//  BirthdayListVC.swift
//  BirthdayReminder
//
//  Created by Евгений Борисов on 20.09.2023.
//

import UIKit

class BirthdayListVC: UIViewController {
    
    var birthdayViews = [UIStackView]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func unwindSegueForAddBirthdayVC(segue: UIStoryboardSegue) {
        guard let addVC = segue.source as? AddBirthdayVC else {
            return
        }
        
        let name = addVC.personInfoTextFields[0].text!
        let date = addVC.personInfoTextFields[1].text!
        let age = addVC.personInfoTextFields[2].text!
        let instagram = addVC.personInfoTextFields[4].text!
        
        addBirtdayViewWith(name: name, date: date, age: age, instagram: instagram)
    }
    
    
    
    
    func addBirtdayViewWith(name: String, date: String, age: String, instagram: String) {
        let birthdayView = UIStackView()
        self.view.addSubview(birthdayView)
        configureBirtdayView(birthdayView)
        let image = getBirthdayImageView()
        let personInfoStackView = getPersonInfoViewWith(name: name, date: date, age: age, instagram: instagram)
        birthdayView.addArrangedSubview(image)
        birthdayView.addArrangedSubview(personInfoStackView)
        birthdayViews.append(birthdayView)
    }
    
    func getBirthdayImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.tintColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return imageView
    }
    
    func getPersonInfoViewWith(name: String, date: String, age: String, instagram: String) -> UIStackView {
        let infoStackView = UIStackView()
        infoStackView.axis = .vertical
        infoStackView.distribution = .fillEqually
        infoStackView.spacing = -8
        
        let nameLabel = UILabel()
        nameLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17)
        let infoLabel = UILabel()
        infoLabel.numberOfLines = 0
        infoLabel.font = infoLabel.font.withSize(14)
        infoLabel.textColor = .gray
        
        let information = getInfoFrom(name: name, date: date, age: age, instagram: instagram)
        nameLabel.text = information.name
        infoLabel.text = information.info
        
        infoStackView.addArrangedSubview(nameLabel)
        infoStackView.addArrangedSubview(infoLabel)

        return infoStackView
    }
    
    func getInfoFrom(name: String, date: String, age: String, instagram: String) -> (name: String, info: String) {
        let parsedName = name.isEmpty ? "No name" : name
        var info = ""
        if !date.isEmpty {
            info += "Birthday: \(date),"
        }
        
        if !age.isEmpty {
            info += " current age: \(age)"
        }
        
        if !instagram.isEmpty {
            info += "\nInstagram: @\(instagram)"
        }
        
        return (parsedName, info.isEmpty ? "No information" : info)
        
    }
    
    func configureBirtdayView(_ birthdayView: UIStackView) {
        birthdayView.translatesAutoresizingMaskIntoConstraints = false
        birthdayView.axis = .horizontal
        birthdayView.distribution = .fill
        birthdayView.spacing = 10
        
        if birthdayViews.isEmpty {
            NSLayoutConstraint.activate([
                birthdayView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                birthdayView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                birthdayView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            ])
        } else {
            let lastBirtdayView = birthdayViews.last!
            NSLayoutConstraint.activate([
                birthdayView.topAnchor.constraint(equalTo: lastBirtdayView.bottomAnchor, constant: 20),
                birthdayView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                birthdayView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            ])
        }
        
    }


}
