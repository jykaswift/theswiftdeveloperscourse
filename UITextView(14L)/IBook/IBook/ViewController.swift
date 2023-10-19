//
//  ViewController.swift
//  IBook
//
//  Created by Евгений Борисов on 18.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let colorButtons = [
        ColorButton(color: .green),
        ColorButton(color: .red),
        ColorButton(color: .blue),
        ColorButton(color: .black),
        ColorButton(color: .yellow),
        ColorButton(color: .brown),
    ]
    
    var isBold = false
    
    var isNightMode = false
    
    var weightButtonsConfiguration: UIButton.Configuration {
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        return configuration
    }
    
    let regularBoldFonts = [
        "Georgia" : "Georgia-Bold",
        "TimesNewRomanPSMT": "TimesNewRomanPS-BoldMT",
        "ArialMT": "Arial-BoldMT"
    ]
    
    let boldRegularFonts = [
        "Georgia-Bold" : "Georgia",
        "TimesNewRomanPS-BoldMT": "TimesNewRomanPSMT",
        "Arial-BoldMT": "ArialMT"
    ]
    
    let fonts = [
        "Georgia" : "Georgia",
        "Times New Roman": "TimesNewRomanPSMT",
        "Arial": "ArialMT"
    ]
    
    let boldFonts = [
        "Georgia" : "Georgia-Bold",
        "Times New Roman": "TimesNewRomanPS-BoldMT",
        "Arial": "Arial-BoldMT"
    ]
    
    lazy var boldButton = {
        let boldButton = UIButton(type: .custom)
        boldButton.configuration = weightButtonsConfiguration
        boldButton.configuration!.image = UIImage(systemName: "character", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))
        boldButton.translatesAutoresizingMaskIntoConstraints = false
        boldButton.layer.borderWidth = 1
        boldButton.layer.borderColor = UIColor.black.cgColor
        boldButton.layer.cornerRadius = 10
        boldButton.tintColor = .black
        return boldButton
    }()
    
    lazy var regularButton = {
        let regularButton = UIButton(type: .custom)
        regularButton.configuration = weightButtonsConfiguration
        regularButton.configuration!.image = UIImage(systemName: "character", withConfiguration: UIImage.SymbolConfiguration(weight: .light))
        regularButton.translatesAutoresizingMaskIntoConstraints = false
        regularButton.layer.borderWidth = 1
        regularButton.layer.borderColor = UIColor.black.cgColor
        regularButton.layer.cornerRadius = 10
        regularButton.tintColor = .white
        regularButton.backgroundColor = .black
        return regularButton
    }()
    
    
    lazy var fontPicker = { [self] in
        let fontPicker = UIPickerView()
        fontPicker.translatesAutoresizingMaskIntoConstraints = false
        fontPicker.delegate = self
        fontPicker.dataSource = self
        fontPicker.layer.borderWidth = 1
        fontPicker.layer.borderColor = UIColor.black.cgColor
        
        return fontPicker
    }()
    
    
    lazy var fontSlider = {
        let fontSlider = UISlider()
        fontSlider.minimumValue = 10
        fontSlider.maximumValue = 32
        fontSlider.translatesAutoresizingMaskIntoConstraints = false
        fontSlider.minimumValueImage = UIImage(systemName: "character", withConfiguration: UIImage.SymbolConfiguration(scale: .small))
        fontSlider.maximumValueImage = UIImage(systemName: "character", withConfiguration: UIImage.SymbolConfiguration(scale: .large))
        fontSlider.setThumbImage(UIImage(systemName: "circle.fill"), for: .normal)
        fontSlider.setThumbImage(UIImage(systemName: "circle.fill"), for: .highlighted)
        fontSlider.maximumTrackTintColor = .gray
        fontSlider.tintColor = .black
        fontSlider.value = 18
        return fontSlider
    }()
    
    lazy var colorButtonContainer = {
        let colorButtonContainer = UIStackView()
        colorButtonContainer.axis = .horizontal
        colorButtonContainer.distribution = .equalCentering
        colorButtonContainer.translatesAutoresizingMaskIntoConstraints = false
        colorButtonContainer.alignment = .center
        colorButtonContainer.spacing = 5
        return colorButtonContainer
    }()
    
    lazy var nightButton = {
        let nightButton = UIButton(type: .custom)
        nightButton.setImage(UIImage(systemName: "moon.zzz.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25)), for: .normal)
        nightButton.tintColor = .black
        nightButton.translatesAutoresizingMaskIntoConstraints = false
        return nightButton
    }()
    
    lazy var configurationView = {
        let configurationView = UIView()
        configurationView.backgroundColor = .systemGray5.withAlphaComponent(0.9)
        configurationView.translatesAutoresizingMaskIntoConstraints = false
        configurationView.layer.cornerRadius = 12
        configurationView.isHidden = true
        return configurationView
    }()
    
    lazy var mainTextView = {
        let mainTextView = UITextView()
        mainTextView.text = Text.text
        mainTextView.translatesAutoresizingMaskIntoConstraints = false
        mainTextView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        mainTextView.isEditable = false
        mainTextView.font = UIFont(name: "ArialMT", size: 18)
        return mainTextView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        setupNavigationBar()
        setupView()
        setupActions()
    }
    
    func setupActions() {
        setupActionColorButtons()
        nightButton.addTarget(self, action: #selector(nightButtonTapped), for: .touchUpInside)
        fontSlider.addTarget(self, action: #selector(fontSliderMoved), for: .valueChanged)
        boldButton.addTarget(self, action: #selector(boldButtonTapped), for: .touchUpInside)
        regularButton.addTarget(self, action: #selector(regularButtonTapped), for: .touchUpInside)
    }
    
    @objc func boldButtonTapped() {
        mainTextView.font = UIFont(name: regularBoldFonts[mainTextView.font!.fontName]!, size: CGFloat(Int(fontSlider.value)))
        boldButton.tintColor = .white
        boldButton.backgroundColor = .black
        regularButton.tintColor = .black
        regularButton.backgroundColor = .clear
        isBold = true
    }
    
    @objc func regularButtonTapped() {
        isBold = false
        mainTextView.font = UIFont(name: boldRegularFonts[mainTextView.font!.fontName]!, size: CGFloat(Int(fontSlider.value)))
        boldButton.tintColor = .black
        boldButton.backgroundColor = .clear
        regularButton.tintColor = .white
        regularButton.backgroundColor = .black
    }
    
    @objc func fontSliderMoved() {
        mainTextView.font = mainTextView.font?.withSize(CGFloat(Int(fontSlider.value)))
    }
    
    
    @objc func nightButtonTapped() {
        if isNightMode {
            navigationController?.navigationBar.tintColor = .black
            view.backgroundColor = .white
            navigationController?.navigationBar.barTintColor = .white
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
            mainTextView.backgroundColor = .white
            mainTextView.textColor = .black
            nightButton.tintColor = .black
        } else {
            nightButton.tintColor = .systemGray6
            view.backgroundColor = .black
            navigationController?.navigationBar.tintColor = .systemGray6
            navigationController?.navigationBar.barTintColor = .black
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.systemGray6]
            mainTextView.backgroundColor = .black
            mainTextView.textColor = .systemGray6
        }
        
        isNightMode = !isNightMode
    }
    
    func setupActionColorButtons() {
        for button in colorButtons {
            button.addTarget(self, action: #selector(colorButtonTapped(sender:)), for: .touchUpInside)
        }
    }
    
    func setupView() {
        setupColorButtons()
        layout()
    }
    
    func setupColorButtons() {
        for button in colorButtons {
            colorButtonContainer.addArrangedSubview(button)
        }
    }
    
    @objc func colorButtonTapped(sender: ColorButton) {
        mainTextView.textColor = sender.color
    }
    
    func layout() {
        view.addSubview(mainTextView)
        view.addSubview(configurationView)
        configurationView.addSubview(colorButtonContainer)
        configurationView.addSubview(nightButton)
        configurationView.addSubview(fontSlider)
        configurationView.addSubview(boldButton)
        configurationView.addSubview(regularButton)
        configurationView.addSubview(fontPicker)
       
        
        
        NSLayoutConstraint.activate([
            mainTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            configurationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            configurationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            configurationView.widthAnchor.constraint(
                equalToConstant: (CGFloat(colorButtons.count) * (ColorButton.size + colorButtonContainer.spacing)) + 50
            ),
            configurationView.heightAnchor.constraint(equalToConstant: 200)
        ])
    
        
        NSLayoutConstraint.activate([
            nightButton.trailingAnchor.constraint(equalTo: configurationView.trailingAnchor, constant: -10),
            nightButton.topAnchor.constraint(equalTo: colorButtonContainer.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            colorButtonContainer.topAnchor.constraint(equalTo: configurationView.topAnchor, constant: 10),
            colorButtonContainer.trailingAnchor.constraint(equalTo: nightButton.leadingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            fontSlider.topAnchor.constraint(equalTo: nightButton.bottomAnchor, constant: 10),
            fontSlider.leadingAnchor.constraint(equalTo: configurationView.leadingAnchor, constant: 5),
            fontSlider.trailingAnchor.constraint(equalTo: configurationView.trailingAnchor, constant: -5),
        ])
        
        NSLayoutConstraint.activate([
            regularButton.topAnchor.constraint(equalTo: fontSlider.bottomAnchor, constant: 5),
            boldButton.topAnchor.constraint(equalTo: regularButton.topAnchor),
            regularButton.leadingAnchor.constraint(equalTo: fontSlider.leadingAnchor),
            regularButton.trailingAnchor.constraint(equalTo: boldButton.leadingAnchor, constant: -5),
        ])
        
        NSLayoutConstraint.activate([
            fontPicker.topAnchor.constraint(equalTo: regularButton.bottomAnchor, constant: 10),
            fontPicker.leadingAnchor.constraint(equalTo: fontSlider.leadingAnchor),
            fontPicker.trailingAnchor.constraint(equalTo: fontSlider.trailingAnchor),
            fontPicker.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        
    }
    
    func setupNavigationBar() {
        navigationItem.title = "IBook"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareBUttonTapped))
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "textformat"), style: .plain, target: self, action: #selector(editButtonTapped))
    }
    
    @objc func editButtonTapped(sender: UIBarButtonItem) {
        
        if configurationView.isHidden {
            sender.image = UIImage(systemName: "xmark.circle")
        } else {
            sender.image = UIImage(systemName: "textformat")
        }
       
        configurationView.isHidden = !configurationView.isHidden
    }
    
    @objc func shareBUttonTapped(sender: UIBarButtonItem) {
        let activityController = UIActivityViewController(activityItems: [mainTextView.text!], applicationActivities: .none)
        activityController.popoverPresentationController?.sourceView = self.view
        self.present(activityController, animated: true)
    }


}


extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        50
    }
 
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        fonts.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        label.text = fonts.keys.sorted()[row]
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if isBold {
            mainTextView.font = UIFont(name: boldFonts[fonts.keys.sorted()[row]] ?? "Arial", size: CGFloat(fontSlider.value))
        } else {
            mainTextView.font = UIFont(name: fonts[fonts.keys.sorted()[row]] ?? "Arial", size: CGFloat(fontSlider.value))
        }
        
    }
    

    
   
}


class ColorButton: UIButton {
    
    static var size: CGFloat = 25
    
    var color: UIColor = .red
    
    
    convenience init(color: UIColor) {
        self.init()
        self.color = color
        self.backgroundColor = color
        layout()
        makeItRound()
    }
    
    
    func layout() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: ColorButton.size).isActive = true
        self.heightAnchor.constraint(equalToConstant: ColorButton.size).isActive = true
    }
    
    func makeItRound() {
        self.layer.cornerRadius =  12.5
        self.clipsToBounds = true
    }
    
}
