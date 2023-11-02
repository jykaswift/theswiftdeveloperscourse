//
//  ViewController.swift
//  shop
//
//  Created by Евгений Борисов on 31.10.2023.
//

import UIKit

class MainVC: UIViewController {
    
    lazy var searchTitle = {
        let searchTitle = UILabel()
        searchTitle.text = "Поиск"
        searchTitle.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        searchTitle.translatesAutoresizingMaskIntoConstraints = false
        searchTitle.textColor = .white
        
        return searchTitle
    }()
    
    lazy var requestOptionsTitle = {
        let requestOptionsTitle = UILabel()
        requestOptionsTitle.text = "Варианты запросов"
        requestOptionsTitle.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        requestOptionsTitle.textColor = .white
        requestOptionsTitle.translatesAutoresizingMaskIntoConstraints = false
        return requestOptionsTitle
    }()
    
    lazy var imageStackView = {
        let imageStackView = UIStackView()
        imageStackView.axis = .horizontal
        imageStackView.distribution = .fill
        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        imageStackView.spacing = 10
        return imageStackView
    }()
    
    lazy var recentlyViewedTitle = {
        let recentlyViewedTitle = UILabel()
        recentlyViewedTitle.text = "Недавно просмотренные"
        recentlyViewedTitle.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        recentlyViewedTitle.textColor = .white
        recentlyViewedTitle.translatesAutoresizingMaskIntoConstraints = false
        return recentlyViewedTitle
    }()
    
    lazy var clearButton = {
        let clearButton = UIButton(configuration: .plain())
        clearButton.setTitle("Очистить", for: .normal)
        clearButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        return clearButton
    }()
    
    lazy var searchField = {
        let searchField = TextField()
        searchField.layer.cornerRadius = 8
        searchField.adjustsFontSizeToFitWidth = true
        searchField.leftViewMode = .always
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: 28, height: 20) )
        let iconView  = UIImageView(frame: CGRect(x: 8, y: 0, width: 20, height: 20))
        iconView.image = UIImage(systemName: "magnifyingglass")
        outerView.addSubview(iconView)
        searchField.leftView = outerView
        searchField.translatesAutoresizingMaskIntoConstraints = false
        searchField.backgroundColor = UIColor(red: 28, green: 28, blue: 30)
        searchField.font = UIFont.systemFont(ofSize: 20)
        searchField.textColor = .lightGray
        searchField.tintColor = .lightGray
        searchField.attributedPlaceholder = NSAttributedString(
            string: "Поиск по продуктам и магазинам",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        return searchField
    }()
    
    lazy var imageScrollView = {
        let imageScrollView = UIScrollView()
        imageScrollView.translatesAutoresizingMaskIntoConstraints = false
        imageScrollView.showsHorizontalScrollIndicator = false
        return imageScrollView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        setupView()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated:true)
    }
    
    func setProducts() {
        let aegis = Product(name: "AEGIS TI 2023 выигранный командой Team Spirit", mainImage: UIImage(named: "aegis"), price: 2000)
        aegis.addImage(image: UIImage(named: "aegis2"))
        let tapok = Product(name: "Тапки. Осторожно! Заминированы", mainImage: UIImage(named: "tapok"), price: 3999)
        let macbook = Product(name: "Macbook pro 2022 года выпуска", mainImage: UIImage(named: "macbook"), price: 22999)
        macbook.addImage(image: UIImage(named: "macbook2"))
        macbook.addImage(image: UIImage(named: "macbook3"))
        let gloves = Product(name: "Боксерские перчатки \"Everlast\"", mainImage: UIImage(named: "box"), price: 6000)
        
        imageStackView.addArrangedSubview(createProductViewWith(product: aegis))
        imageStackView.addArrangedSubview(createProductViewWith(product: tapok))
        imageStackView.addArrangedSubview(createProductViewWith(product: macbook))
        imageStackView.addArrangedSubview(createProductViewWith(product: gloves))
    }
    
   

    func createPotentialRequestWith(text: String) -> UIStackView {
    
        let requestContainer = UIStackView()
        requestContainer.axis = .horizontal
        requestContainer.spacing = 10
        requestContainer.alignment = .center
        
        let requestTitle = UILabel()
        requestTitle.text = text
        requestTitle.font = UIFont.systemFont(ofSize: 18)
        requestTitle.textColor = .white
        
        let requestIcon = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        requestIcon.contentMode = .scaleAspectFit
        requestIcon.translatesAutoresizingMaskIntoConstraints = false
        requestIcon.widthAnchor.constraint(equalToConstant: 17).isActive = true
        requestIcon.heightAnchor.constraint(equalToConstant: 17).isActive = true
        requestIcon.tintColor = .lightGray
        
        requestContainer.addArrangedSubview(requestIcon)
        requestContainer.addArrangedSubview(requestTitle)
        
        return requestContainer
    }
    
    
    func createProductViewWith(product: Product) -> UIView {
        let productView = ProductView(product: product)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onProductTapped(sender:)))
        productView.addGestureRecognizer(tapGestureRecognizer)
        return productView
    }
    
    @objc func onProductTapped(sender: UITapGestureRecognizer) {
        
        guard let productView = sender.view as? ProductView else { return }
        let detailVC = DetailVC()
        detailVC.product = productView.product
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func setupView() {
        layout()
        setPotentialRequests()
        setProducts()
    }
    
    func setPotentialRequests() {
        let requestsContainer = UIStackView()
        requestsContainer.axis = .vertical
        requestsContainer.spacing = 20
        requestsContainer.translatesAutoresizingMaskIntoConstraints = false
        
        requestsContainer.addArrangedSubview(createPotentialRequestWith(text: "AirPods"))
        requestsContainer.addArrangedSubview(createPotentialRequestWith(text: "AppleCare"))
        requestsContainer.addArrangedSubview(createPotentialRequestWith(text: "Beats"))
        requestsContainer.addArrangedSubview(createPotentialRequestWith(text: "Сравните модели IPhone"))
        
        self.view.addSubview(requestsContainer)
        NSLayoutConstraint.activate([
            requestsContainer.topAnchor.constraint(equalTo: requestOptionsTitle.bottomAnchor, constant: 20),
            requestsContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            requestsContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
        
    }
    
    func layout() {
        
        self.view.addSubview(searchTitle)
        self.view.addSubview(searchField)
        self.view.addSubview(recentlyViewedTitle)
        self.view.addSubview(clearButton)
        self.view.addSubview(imageScrollView)
        imageScrollView.addSubview(imageStackView)
        self.view.addSubview(requestOptionsTitle)

        NSLayoutConstraint.activate([
            searchTitle.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            searchTitle.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalToSystemSpacingBelow: searchTitle.bottomAnchor, multiplier: 1),
            searchField.leadingAnchor.constraint(equalTo: searchTitle.leadingAnchor),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: searchField.trailingAnchor, multiplier: 1),
        ])
        
        NSLayoutConstraint.activate([
            recentlyViewedTitle.topAnchor.constraint(equalToSystemSpacingBelow: searchField.bottomAnchor, multiplier: 4),
            recentlyViewedTitle.leadingAnchor.constraint(equalTo: searchTitle.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            clearButton.trailingAnchor.constraint(equalTo: searchField.trailingAnchor),
            clearButton.bottomAnchor.constraint(equalTo: recentlyViewedTitle.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            imageScrollView.topAnchor.constraint(equalTo: recentlyViewedTitle.bottomAnchor, constant: 15),
            imageScrollView.leadingAnchor.constraint(equalTo: recentlyViewedTitle.leadingAnchor),
            imageScrollView.trailingAnchor.constraint(equalTo: searchField.trailingAnchor),
            imageScrollView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            imageStackView.topAnchor.constraint(equalTo: imageScrollView.topAnchor),
            imageStackView.bottomAnchor.constraint(equalTo: imageScrollView.bottomAnchor),
            imageStackView.leadingAnchor.constraint(equalTo: imageScrollView.leadingAnchor),
            imageStackView.trailingAnchor.constraint(equalTo: imageScrollView.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            requestOptionsTitle.leadingAnchor.constraint(equalTo: recentlyViewedTitle.leadingAnchor),
            requestOptionsTitle.topAnchor.constraint(equalTo: imageScrollView.bottomAnchor, constant: 20)
        ])
    }


}

class ProductView: UIView {
    
    var product: Product
    
    init(product: Product) {
        self.product = product
        super.init(frame: CGRectZero)
        configuration()
    }
    
    func configuration() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 8
        self.backgroundColor = UIColor(red: 28, green: 28, blue: 30)
        let productImageView = UIImageView(image: product.mainImage)
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.contentMode = .scaleAspectFit
        let descriptionLabel = UILabel()
        descriptionLabel.text = product.name
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(productImageView)
        self.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 200),
            self.widthAnchor.constraint(equalToConstant: 140),
        ])
        
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            productImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            productImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            productImageView.heightAnchor.constraint(equalToConstant: 95)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 15),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class TextField: UITextField {

    let padding = UIEdgeInsets(top: 8, left: 33, bottom: 8, right: 8)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
