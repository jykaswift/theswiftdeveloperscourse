//
//  AddBirthdayVC.swift
//  BirthdayReminder
//
//  Created by Евгений Борисов on 20.09.2023.
//

import UIKit

class AddBirthdayVC: UIViewController {
    
    var pickerData = ["Male", "Female"]

    @IBOutlet var personInfoTextFields: [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFields()
    }
 
    func configureTextFields() {
        for (i, textField) in personInfoTextFields.enumerated() {
            textField.addBottomBorder()
            addFunctionalTo(textField: textField, withIndex: i)
        }
    }
    
    func addFunctionalTo(textField: UITextField, withIndex index: Int) {
        
        switch index {
        case 1:
            addDatePickerTo(textField: textField, withIndex: index)
        case 2, 3:
            addPickerViewTo(textField: textField, withIndex: index)
        default:
            break
        }
    }
    
    func addDatePickerTo(textField: UITextField, withIndex index: Int) {
        let datePicker = UIDatePicker()
        datePicker.tag = index
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(onDatePickerChanged(sender:)), for: .valueChanged)
        textField.inputView = datePicker
        addDoneButtonTo(textField: textField)
    }
    
    @objc func onDatePickerChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "d MMMM"
        let text = dateFormatter.string(from: sender.date)
        personInfoTextFields[sender.tag].text = text
    }
    
    
    func addPickerViewTo(textField: UITextField, withIndex index: Int) {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.tag = index
        textField.inputView = pickerView
        addDoneButtonTo(textField: textField)
    }
   
    
    func addDoneButtonTo(textField: UITextField) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonTapped))
        toolbar.setItems([doneBtn], animated: true)
        
        textField.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonTapped() {
        self.view.endEditing(true)
    }
    
    
    @IBAction func instagramTFTouched(_ sender: Any) {
        showInstaAlert()
    }
    
    func showInstaAlert() {
        let alert = UIAlertController(title: nil, message: "Enter instagram username", preferredStyle: .alert)
        
        alert.addTextField() {textField in
            textField.placeholder = "Enter userName"
        }
        
        let okAction = UIAlertAction(title: "Ok", style: .default) {_ in
            self.personInfoTextFields[4].text = alert.textFields![0].text
        }
        
        let cancelAction = UIAlertAction(title: "cancel", style: .default)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

extension AddBirthdayVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 2:
            return 100
        default:
            return pickerData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 2:
            return String(row + 1)
        default:
            return pickerData[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let pickerTag = pickerView.tag
        let text = pickerTag == 2 ? String(row + 1) : pickerData[row]
        personInfoTextFields[pickerView.tag].text = text
    }
}
