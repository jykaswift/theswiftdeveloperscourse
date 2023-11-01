//
//  DetailVC.swift
//  shop
//
//  Created by Евгений Борисов on 01.11.2023.
//

import UIKit

class DetailVC: UIViewController {
    
    lazy var addToBasketButton = {
        let addToBasketButton = UIButton()
        addToBasketButton.setTitle("Добавить в корзину", for: .normal)
        addToBasketButton.backgroundColor = .systemBlue
        addToBasketButton.translatesAutoresizingMaskIntoConstraints = false
        addToBasketButton.layer.cornerRadius = 8
        return addToBasketButton
    }()
    

    
    lazy var nameTitleLabel = {
        let nameTitleLabel = UILabel()
        nameTitleLabel.text = product.name
        nameTitleLabel.textColor = .white
        nameTitleLabel.text = product.name
        nameTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        nameTitleLabel.numberOfLines = 0
        nameTitleLabel.textAlignment = .center
        nameTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameTitleLabel
    }()
    
    lazy var whiteButton = ColorButton(color: .white)
    
    lazy var blackButton = ColorButton(color: .darkGray)
    
    var timerForShowScrollIndicator: Timer?
    
    lazy var priceLabel = {
        let priceLabel = UILabel()
        priceLabel.text = "\(product.price) руб."
        priceLabel.textColor = .lightGray
        priceLabel.font = UIFont.systemFont(ofSize: 16)
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        return priceLabel
    }()
    
    lazy var imagesScrollView = {
        let imagesScrollView = UIScrollView()
        imagesScrollView.translatesAutoresizingMaskIntoConstraints = false
        imagesScrollView.isPagingEnabled = true
        imagesScrollView.indicatorStyle = .white
        imagesScrollView.showsHorizontalScrollIndicator = true
        imagesScrollView.backgroundColor = UIColor(red: 28, green: 28, blue: 30, alpha: 1)
        if product.otherImages.isEmpty {
            imagesScrollView.backgroundColor = .white
        }
        imagesScrollView.horizontalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: -2, right: 0)
        return imagesScrollView
    }()
    
    var product: Product!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        addActions()
        setupNavBar()
    }
    
    func setupNavBar() {
        let likeButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(likeButtonTapped))        
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(likeButtonTapped))
        navigationItem.rightBarButtonItems = [likeButton, shareButton]
    }
    
    @objc func likeButtonTapped() {}
    
    func addActions() {
        whiteButton.addTarget(self, action: #selector(colorButtonTapped(sender:)), for: .touchUpInside)
        blackButton.addTarget(self, action: #selector(colorButtonTapped(sender:)), for: .touchUpInside)
    }
    
    @objc func colorButtonTapped(sender: UIButton) {
        guard let button = sender as? ColorButton else { return }
        
        switch button.color {
        case .white:
            blackButton.layer.borderWidth = 0
            whiteButton.layer.borderWidth = 2
            whiteButton.layer.borderColor = UIColor.systemBlue.cgColor
        default:
            whiteButton.layer.borderWidth = 0
            blackButton.layer.borderWidth = 2
            blackButton.layer.borderColor = UIColor.systemBlue.cgColor
        }
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.imagesScrollView.flashScrollIndicators()
        startTimerForShowScrollIndicator()
    }
    
    @objc func showScrollIndicatorsInContacts() {
        UIView.animate(withDuration: 0.001) {
            self.imagesScrollView.flashScrollIndicators()
        }
    }
        
    func startTimerForShowScrollIndicator() {
        self.timerForShowScrollIndicator = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.showScrollIndicatorsInContacts), userInfo: nil, repeats: true)
    }
    
    
    
    func setupView() {
        view.backgroundColor = .black
        layout()
        setImages()
    }
    
    func setImages() {
        let imageStackView = UIStackView()
        imageStackView.axis = .horizontal
        imageStackView.distribution = .fill
        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        imageStackView.spacing = 0
        
        let firstImage = UIImageView(image: product.mainImage)
        firstImage.backgroundColor = .black
        firstImage.contentMode = .scaleAspectFit
        firstImage.translatesAutoresizingMaskIntoConstraints = false

        imagesScrollView.addSubview(imageStackView)
        imageStackView.addArrangedSubview(firstImage)
        
        
        
        for image in product.otherImages {
            let productImage = UIImageView(image: image)
            productImage.backgroundColor = .black
            productImage.contentMode = .scaleAspectFit
            productImage.translatesAutoresizingMaskIntoConstraints = false
            
            imageStackView.addArrangedSubview(productImage)
            
            NSLayoutConstraint.activate([
                productImage.heightAnchor.constraint(equalTo: imageStackView.heightAnchor),
                productImage.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor)
            ])
        }
        
 
        NSLayoutConstraint.activate([
            imageStackView.topAnchor.constraint(equalTo: imagesScrollView.topAnchor),
            imageStackView.bottomAnchor.constraint(equalTo: imagesScrollView.bottomAnchor),
            imageStackView.leadingAnchor.constraint(equalTo: imagesScrollView.leadingAnchor),
            imageStackView.trailingAnchor.constraint(equalTo: imagesScrollView.trailingAnchor),
            imageStackView.heightAnchor.constraint(equalToConstant: 245)
        ])
        
       
        
        NSLayoutConstraint.activate([
            firstImage.heightAnchor.constraint(equalTo: imageStackView.heightAnchor),
            firstImage.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor)
        ])
        

        
        
    }
    
    func layout() {
        self.view.addSubview(nameTitleLabel)
        self.view.addSubview(priceLabel)
        self.view.addSubview(imagesScrollView)
        self.view.addSubview(addToBasketButton)
 
        let colorButtonStackView = UIStackView()
        colorButtonStackView.axis = .horizontal
        colorButtonStackView.addArrangedSubview(blackButton)
        colorButtonStackView.addArrangedSubview(whiteButton)
        colorButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        colorButtonStackView.spacing = 10
        self.view.addSubview(colorButtonStackView)
      
        
        NSLayoutConstraint.activate([
            nameTitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            nameTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            nameTitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: nameTitleLabel.bottomAnchor, constant: 5),
            priceLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            imagesScrollView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 15),
            imagesScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imagesScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            imagesScrollView.heightAnchor.constraint(equalToConstant: 250)
        ])
        
        NSLayoutConstraint.activate([
            colorButtonStackView.topAnchor.constraint(equalTo: imagesScrollView.bottomAnchor, constant: 30),
            colorButtonStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            addToBasketButton.topAnchor.constraint(equalTo: colorButtonStackView.bottomAnchor, constant: 20),
            addToBasketButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            addToBasketButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class ColorButton: UIButton {
    
    var color: UIColor
    
    init(color: UIColor = .white) {
        self.color = color
        super.init(frame: CGRectZero)
        configuration(withColor: color)
    }
    
    func configuration(withColor color: UIColor) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 20
        self.backgroundColor = color
        if color.cgColor === UIColor.darkGray.cgColor {
            self.layer.borderWidth = 2
            self.layer.borderColor = UIColor.systemBlue.cgColor
        }
        let innerBorder = CALayer()
        innerBorder.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        innerBorder.borderColor = UIColor.black.cgColor
        innerBorder.borderWidth = 4
        innerBorder.cornerRadius = 20
        self.layer.addSublayer(innerBorder)
        self.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
