//
//  MainViewController.swift
//  DotaInformation
//
//  Created by Евгений Борисов on 12.10.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    let heroes = ["Pudge", "Riki", "Invoker"]
    
    lazy var saveButton = {
        let saveButton = UIButton(type: .custom)
        saveButton.backgroundColor = .black
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        return saveButton
    }()
    
    lazy var heroPickerView = { [self] in
        let heroPickerView = UIPickerView()
        heroPickerView.delegate = self
        heroPickerView.dataSource = self
        return heroPickerView
    }()
    
    lazy var toolBar = { [self] in
        let toolBar = UIToolbar()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(toolbarDonePressed))
        
        toolBar.sizeToFit()
        toolBar.setItems([doneButton], animated: true)
        return toolBar
    }()
    
    lazy var heroPickerLabel = {
        let heroPickerLabel = UICustomLabel()
        heroPickerLabel.text = "Favorite hero:"
        return heroPickerLabel
    }()
    
    lazy var favoriteHeroTF = { [self] in
        let favoriteHeroTF = UITextField()
        let heroImageView = UIImageView(image: UIImage(systemName: "accessibility"))
        heroImageView.sizeToFit()
        favoriteHeroTF.rightViewMode = .always
        favoriteHeroTF.rightView = heroImageView
        favoriteHeroTF.inputView = heroPickerView
        favoriteHeroTF.inputAccessoryView = toolBar
        favoriteHeroTF.translatesAutoresizingMaskIntoConstraints = false
        favoriteHeroTF.borderStyle = .none
        favoriteHeroTF.placeholder = "Chose hero"
        favoriteHeroTF.tintColor = .black
        favoriteHeroTF.addBottomBorder()
        return favoriteHeroTF
    }()
    
    lazy var favoriteSideLabel = {
        let favoriteSideLabel = UICustomLabel()
        favoriteSideLabel.text = "Favorite side:"
        return favoriteSideLabel
    }()
    lazy var favoriteSideControl = {
        let sideControl = UISegmentedControl(items: ["Radiant", "Dire"])
        sideControl.translatesAutoresizingMaskIntoConstraints = false
        sideControl.backgroundColor = .white
        sideControl.setBackgroundImage(UIImage(color: .clear, size: CGSize(width: 1, height: 10)), for: .normal, barMetrics: .default)
        sideControl.setBackgroundImage(UIImage(color: .green, size: CGSize(width: 1, height: 10)), for: .selected, barMetrics: .default)
        sideControl.layer.borderWidth = 1
        sideControl.layer.borderColor = UIColor.gray.cgColor
        return sideControl
    }()
    
    lazy var mmrCountLabel = {
        let mmrCountLabel = UICustomLabel()
        mmrCountLabel.text = "MMR:"
        return mmrCountLabel
    }()
    
    lazy var mmrTextField = {
        let mmrTextField = UITextField()
        mmrTextField.addBottomBorder()
        mmrTextField.text = "5000"
        mmrTextField.translatesAutoresizingMaskIntoConstraints = false
        mmrTextField.returnKeyType = .done
        mmrTextField.keyboardType = .numberPad
        mmrTextField.inputAccessoryView = toolBar
        return mmrTextField
    }()
    
    lazy var mmrSlider = {
        let mmrSlider = UISlider()
        mmrSlider.minimumValue = 0
        mmrSlider.maximumValue = 13000
        mmrSlider.value = 5000
        mmrSlider.tintColor = .black
        mmrSlider.translatesAutoresizingMaskIntoConstraints = false
        mmrSlider.setThumbImage(UIImage.init(systemName: "circle.fill"), for: .normal)
        mmrSlider.setThumbImage(UIImage.init(systemName: "circle.fill"), for: .highlighted)
        return mmrSlider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupActions()
        
        
    }
    
    func setupActions() {
        favoriteSideControl.addTarget(self, action: #selector(favorideSideChanged), for: .valueChanged)
        mmrSlider.addTarget(self, action: #selector(mmrSliderMoved), for: .valueChanged)
        mmrTextField.addTarget(self, action: #selector(mmrTexfieldChanged), for: .editingChanged)
    }
    
    @objc func mmrTexfieldChanged() {
        mmrSlider.value = Float(Int(mmrTextField.text!) ?? 0)
    }
    
    @objc func mmrSliderMoved() {
        mmrTextField.text = "\(Int(mmrSlider.value))"
    }
    
    @objc func favorideSideChanged() {
        if favoriteSideControl.selectedSegmentIndex == 0 {
            favoriteSideControl.setBackgroundImage(UIImage(color: .green, size: CGSize(width: 1, height: 10)), for: .selected, barMetrics: .default)

        } else {
            favoriteSideControl.setBackgroundImage(UIImage(color: .red, size: CGSize(width: 1, height: 10)), for: .selected, barMetrics: .default)
        }
        
    }
    
    func setupView() {
        view.backgroundColor = .white
        setupNavigationBar()
        setupLayout()
    }
    
    func setupLayout() {
        view.addSubview(favoriteHeroTF)
        view.addSubview(heroPickerLabel)
        view.addSubview(favoriteSideLabel)
        view.addSubview(favoriteSideControl)
        view.addSubview(mmrCountLabel)
        view.addSubview(mmrSlider)
        view.addSubview(mmrTextField)
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            heroPickerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            heroPickerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            favoriteHeroTF.centerYAnchor.constraint(equalTo: heroPickerLabel.centerYAnchor),
            favoriteHeroTF.widthAnchor.constraint(equalToConstant: 150),
            favoriteHeroTF.leadingAnchor.constraint(equalTo: heroPickerLabel.trailingAnchor, constant: 10),
        ])
        
        NSLayoutConstraint.activate([
            favoriteSideLabel.topAnchor.constraint(equalTo: heroPickerLabel.bottomAnchor, constant: 20),
            favoriteSideLabel.leadingAnchor.constraint(equalTo: heroPickerLabel.leadingAnchor),
            favoriteSideControl.centerYAnchor.constraint(equalTo: favoriteSideLabel.centerYAnchor),
            favoriteSideControl.leadingAnchor.constraint(equalTo: favoriteSideLabel.trailingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            mmrCountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mmrCountLabel.topAnchor.constraint(equalTo: favoriteSideControl.bottomAnchor, constant: 15),
            mmrSlider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mmrSlider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            mmrSlider.topAnchor.constraint(equalTo: mmrCountLabel.bottomAnchor, constant: 10),
            mmrTextField.centerYAnchor.constraint(equalTo: mmrCountLabel.centerYAnchor),
            mmrTextField.leadingAnchor.constraint(equalTo: mmrCountLabel.trailingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: mmrSlider.bottomAnchor, constant: 15),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: 150),
            saveButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setupNavigationBar() {
        navigationItem.hidesBackButton = true
        navigationItem.title = "Player Information"
    }
    
    @objc func toolbarDonePressed() {
        view.endEditing(true)
    }

  

}

extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        heroes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        heroes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        favoriteHeroTF.text = heroes[row]
    }
    
    
}



class UICustomLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func style() {
        font = UIFont.systemFont(ofSize: 16)
        textColor = .black
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}

public extension UIImage {
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
}
