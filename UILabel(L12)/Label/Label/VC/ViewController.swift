//
//  ViewController.swift
//  Label
//
//  Created by Евгений Борисов on 09.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var mainLabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.shadowColor = .black
        label.shadowOffset = CGSize(width: 1, height: 1)
        return label
    }()
    
    let colors: [UIColor] = [.black, .blue, .red, .orange, .purple]
    
    lazy var fontSlider = { [self] in
       let slider = UISlider()
        slider.minimumValue = 10
        slider.maximumValue = 72
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.value = 16
        
        slider.addTarget(self, action: #selector(onSliderMove), for: .valueChanged)
        
        return slider
    }()
    
    lazy var colorLinesPicker = { [self] in
        
        let colorLinesPicker = UIPickerView()
        colorLinesPicker.delegate = self
        colorLinesPicker.dataSource = self
        colorLinesPicker.translatesAutoresizingMaskIntoConstraints = false
        return colorLinesPicker
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    @objc func onSliderMove() {
        mainLabel.font = mainLabel.font.withSize(CGFloat(Int(fontSlider.value)))
    }
    
    func setUpView() {
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showLabelAlert))
        view.addSubview(mainLabel)
        view.addSubview(fontSlider)
        view.addSubview(colorLinesPicker)
        configureLayout()
    }
    
    func configureLayout() {
        
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            mainLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            mainLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: fontSlider.bottomAnchor, multiplier: 3),
            fontSlider.leadingAnchor.constraint(equalTo: mainLabel.leadingAnchor),
            fontSlider.trailingAnchor.constraint(equalTo: mainLabel.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            colorLinesPicker.bottomAnchor.constraint(equalTo: fontSlider.topAnchor, constant: -10),
            colorLinesPicker.leadingAnchor.constraint(equalTo: mainLabel.leadingAnchor),
            colorLinesPicker.trailingAnchor.constraint(equalTo: mainLabel.trailingAnchor)
        ])
        
    }
    
    

    @objc func showLabelAlert() {
        let alert = UIAlertController(title: "Label alert", message: "Enter a message to show in alert", preferredStyle: .alert)
        alert.addTextField()
        let okAction = UIAlertAction(title: "Enter", style: .default) {[self] _ in
            guard let textField = alert.textFields?.last else { return }
            self.mainLabel.text = textField.text
        }
        alert.addAction(okAction)
        
        self.present(alert, animated: true)
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 1 {
            return colors.count
        } else {
            return 10
        }
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 50
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if component == 1 {
            return ColorView(color: colors[row])
        } else {
            let label = UILabel()
            label.text = String(row)
            return label
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 1 {
            mainLabel.textColor = colors[row]
        } else {
            mainLabel.numberOfLines = row
        }
    }
    
}


class ColorView: UIView {
    
    convenience init(color: UIColor) {
        self.init()
        backgroundColor = color
    }
}
