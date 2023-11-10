//
//  PageConrainerVC.swift
//  shop
//
//  Created by Евгений Борисов on 10.11.2023.
//

import UIKit

class PageConrainerVC: UIViewController {
    
    private var storageManager = StorageManager()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()
    
    private lazy var bottomImageConstraint = imageView.bottomAnchor.constraint(equalTo: textLabel.topAnchor, constant: -900)
    private lazy var textLabelBottomConstraint = textLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 150)
 
    
    private lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.numberOfLines = 0
        textLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .black
        textLabel.textAlignment = .center
        return textLabel
    }()

    
    private lazy var closeButton: UIButton = {
        let closeButton = UIButton()
        closeButton.setImage(UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 24)), for: .normal)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.tintColor = .black
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return closeButton
    }()

    init(text: String, image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        imageView.image = image
        textLabel.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateItemsAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        animateItemsDisappear()

    }
    
    private func setupView() {
        view.backgroundColor = .white
        layout()
    }
    
   
    
    private func animateItemsAppear() {
        UIView.animate(withDuration: 0.4, animations: {
            self.bottomImageConstraint.constant = -20
            self.textLabelBottomConstraint.constant = -250
            self.view.layoutIfNeeded()
            
        })
    }
    
    private func animateItemsDisappear() {
        UIView.animate(withDuration: 0.4, animations: {
            self.bottomImageConstraint.constant = -900
            self.textLabelBottomConstraint.constant = 150
            self.view.layoutIfNeeded()
            
        })
    }
    
    
  
    
    @objc func closeButtonTapped() {
        storageManager.set(true, forKey: .presentationWasViewed)
        self.dismiss(animated: true)
    }
    
  
    
    private func layout() {
        self.view.addSubview(imageView)
        self.view.addSubview(textLabel)
        self.view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
        ])
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            textLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            textLabelBottomConstraint
        ])
        
        NSLayoutConstraint.activate([
            bottomImageConstraint,
            imageView.widthAnchor.constraint(equalTo: textLabel.widthAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            imageView.centerXAnchor.constraint(equalTo: textLabel.centerXAnchor)
        ])
    }
    



}
