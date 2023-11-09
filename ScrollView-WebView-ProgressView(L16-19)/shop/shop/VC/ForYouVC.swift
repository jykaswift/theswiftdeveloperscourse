//
//  ForYouVC.swift
//  shop
//
//  Created by Евгений Борисов on 09.11.2023.
//

import UIKit
import PhotosUI
class ForYouVC: UIViewController {
   
    

    
    enum OrderStatus: Int {
        case processing
        case sent
        case delivered
    }
    private var storageManager = StorageManager()
    
    private lazy var forYouTitleLabel = {
        let forYouTitleLabel = UILabel()
        forYouTitleLabel.text = "Для вас"
        forYouTitleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        forYouTitleLabel.textColor = .black
        forYouTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return forYouTitleLabel
    }()
    
    private lazy var avatarImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.image = UIImage(named: "macbook")
        if let data = storageManager.data(forKey: .avatarPhoto) {
            avatarImageView.image = UIImage(data: data)
        }
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 19
       
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        return avatarImageView
    }()
    

    
    private lazy var topBarBorderView = {
        let topBarBorderView = UIView()
        topBarBorderView.backgroundColor = UIColor(red: 220, green: 221, blue: 221)
        topBarBorderView.translatesAutoresizingMaskIntoConstraints = false
        return topBarBorderView
    }()
    
    private lazy var newsTitleLabel = {
        let newsTitleLabel = UILabel()
        newsTitleLabel.text = "Вот что нового"
        newsTitleLabel.textColor = .black
        newsTitleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        newsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return newsTitleLabel
    }()
    
    private lazy var recomendedBlockView = createRecomendedBlockView(
        image: UIImage(systemName: "square.split.bottomrightquarter")!,
        mainTitle: "Получайте новости о своем заказе в режиме реального времени.",
        additionalTitle: "Включите уведомления чтобы получать новости о своем заказе."
    )
    
    private lazy var newsBlockView = createNewsBlockViewWith(image: UIImage(named: "box")!, status: .sent)
    
    private lazy var recomendedTitleLabel = {
        let recomendedTitleLabel = UILabel()
        recomendedTitleLabel.text = "Рекомендуется вам"
        recomendedTitleLabel.textColor = .black
        recomendedTitleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        recomendedTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return recomendedTitleLabel
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.barStyle = .default
        tabBarController?.tabBar.backgroundColor = UIColor(red: 247, green: 247, blue: 247)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated:true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupAvatarImagePicker()
    }
    
    private func setupAvatarImagePicker() {
        
        let tapAvatar = UITapGestureRecognizer(target: self, action: #selector(avatarTapped))
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(tapAvatar)
    }
    
    @objc func avatarTapped() {

        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        configuration.selectionLimit = 1
        configuration.filter = .images
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    private func setupView() {
        view.backgroundColor = .white
        layout()
    }
    
    private func layout() {
        view.addSubview(forYouTitleLabel)
        view.addSubview(avatarImageView)
        view.addSubview(topBarBorderView)
        view.addSubview(newsTitleLabel)
        view.addSubview(newsBlockView)
        view.addSubview(recomendedTitleLabel)
        view.addSubview(recomendedBlockView)
        
        NSLayoutConstraint.activate([
            forYouTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            forYouTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            forYouTitleLabel.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        NSLayoutConstraint.activate([
            avatarImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            avatarImageView.bottomAnchor.constraint(equalTo: forYouTitleLabel.bottomAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 38),
            avatarImageView.heightAnchor.constraint(equalToConstant: 38),
        ])
        
        NSLayoutConstraint.activate([
            topBarBorderView.heightAnchor.constraint(equalToConstant: 2),
            topBarBorderView.leadingAnchor.constraint(equalTo: forYouTitleLabel.leadingAnchor),
            topBarBorderView.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor),
            topBarBorderView.topAnchor.constraint(equalTo: forYouTitleLabel.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            newsTitleLabel.leadingAnchor.constraint(equalTo: forYouTitleLabel.leadingAnchor),
            newsTitleLabel.topAnchor.constraint(equalTo: topBarBorderView.bottomAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            newsBlockView.leadingAnchor.constraint(equalTo: topBarBorderView.leadingAnchor),
            newsBlockView.trailingAnchor.constraint(equalTo: topBarBorderView.trailingAnchor),
            newsBlockView.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            recomendedTitleLabel.topAnchor.constraint(equalTo: newsBlockView.bottomAnchor, constant: 40),
            recomendedTitleLabel.leadingAnchor.constraint(equalTo: forYouTitleLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            recomendedBlockView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            recomendedBlockView.trailingAnchor.constraint(equalTo: topBarBorderView.trailingAnchor),
            recomendedBlockView.topAnchor.constraint(equalTo: recomendedTitleLabel.bottomAnchor, constant: 20)
        ])
    }
    
    
    private func createNewsBlockViewWith(image: UIImage, status: OrderStatus) -> UIView {
        
        let newBlockView = UIView()
        setupNewBlockView(newBlockView)
        
        let itemImageView = UIImageView(image: image)
        itemImageView.contentMode = .scaleAspectFit
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let orderStatusLabel = UILabel()
        setupOrderStatusLabel(orderStatusLabel, withStatus: status)
        
        let orderInformationLabel = UILabel()
        setupInformationLabel(orderInformationLabel)
        
        let orderInfoStackView = UIStackView()
        setupOrderInfoSV(orderInfoStackView)
        orderInfoStackView.addArrangedSubview(orderStatusLabel)
        orderInfoStackView.addArrangedSubview(orderInformationLabel)
        
        let nextButtonImage = UIImageView(image: UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20)))
        nextButtonImage.translatesAutoresizingMaskIntoConstraints = false
        nextButtonImage.tintColor = UIColor(red: 140, green: 140, blue: 140)
        
        let delimiterView = UIView()
        delimiterView.backgroundColor = UIColor(red: 210, green: 210, blue: 210)
        delimiterView.translatesAutoresizingMaskIntoConstraints = false
        
        let orderProgressView = UIProgressView()
        setupOrderProgressView(orderProgressView, withStatus: status)
        
        let orderProgressStatusStackView = UIStackView()
        setupOrderProgressStatusStackView(orderProgressStatusStackView, withStatus: status)
        
        
        newBlockView.addSubview(itemImageView)
        newBlockView.addSubview(orderInfoStackView)
        newBlockView.addSubview(nextButtonImage)
        newBlockView.addSubview(delimiterView)
        newBlockView.addSubview(orderProgressView)
        newBlockView.addSubview(orderProgressStatusStackView)
        
        NSLayoutConstraint.activate([
            newBlockView.heightAnchor.constraint(equalToConstant: 160)
        ])
        
        NSLayoutConstraint.activate([
            itemImageView.leadingAnchor.constraint(equalTo: newBlockView.leadingAnchor, constant: 15),
            itemImageView.topAnchor.constraint(equalTo: newBlockView.topAnchor, constant: 15),
            itemImageView.heightAnchor.constraint(equalToConstant: 60),
            itemImageView.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            nextButtonImage.trailingAnchor.constraint(equalTo: newBlockView.trailingAnchor, constant: -15),
            nextButtonImage.bottomAnchor.constraint(equalTo: itemImageView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            orderInfoStackView.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 10),
            orderInfoStackView.trailingAnchor.constraint(equalTo: nextButtonImage.leadingAnchor, constant: -10),
            orderInfoStackView.centerYAnchor.constraint(equalTo: itemImageView.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            delimiterView.heightAnchor.constraint(equalToConstant: 1),
            delimiterView.widthAnchor.constraint(equalTo: newBlockView.widthAnchor, multiplier: 1),
            delimiterView.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            orderProgressView.leadingAnchor.constraint(equalTo: itemImageView.leadingAnchor),
            orderProgressView.trailingAnchor.constraint(equalTo: nextButtonImage.trailingAnchor),
            orderProgressView.topAnchor.constraint(equalTo: delimiterView.bottomAnchor, constant: 15),
            orderProgressView.heightAnchor.constraint(equalToConstant: 8)
        ])
        
        NSLayoutConstraint.activate([
            orderProgressStatusStackView.topAnchor.constraint(equalTo: orderProgressView.bottomAnchor, constant: 8),
            orderProgressStatusStackView.widthAnchor.constraint(equalTo: orderProgressView.widthAnchor, multiplier: 1.01),
            orderProgressStatusStackView.centerXAnchor.constraint(equalTo: newBlockView.centerXAnchor)
        ])
        
        return newBlockView
    }
    
     private func setupNewBlockView(_ newBlockView: UIView) {
        newBlockView.backgroundColor = .white
        newBlockView.layer.shadowColor = UIColor.black.cgColor
        newBlockView.layer.shadowOpacity = 0.5
        newBlockView.layer.cornerRadius = 10
        newBlockView.layer.shadowOffset = .zero
        newBlockView.layer.shadowRadius = 5
        newBlockView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupInformationLabel(_ orderInformationLabel: UILabel) {
        orderInformationLabel.textColor = UIColor(red: 145, green: 145, blue: 144)
        orderInformationLabel.font = UIFont.systemFont(ofSize: 14)
        orderInformationLabel.translatesAutoresizingMaskIntoConstraints = false
        orderInformationLabel.text = "1 товар, доставка завтра"
    }
    
    private func setupOrderStatusLabel(_ orderStatusLabel: UILabel, withStatus status: OrderStatus) {
        orderStatusLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        orderStatusLabel.textColor = .black
        
        let orderStatusText: String
        
        switch status {
        case .processing:
            orderStatusText = "Ваш заказ обрабатывается"
        case .sent:
            orderStatusText = "Ваш заказ отправлен"
        case .delivered:
            orderStatusText = "Ваш заказ доставлен"
        }
        
        orderStatusLabel.text = orderStatusText
        orderStatusLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupOrderInfoSV(_ orderInfoStackView: UIStackView) {
        orderInfoStackView.axis = .vertical
        orderInfoStackView.distribution = .fill
        orderInfoStackView.alignment = .top
        orderInfoStackView.spacing = 5
        orderInfoStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupOrderProgressView(_ orderProgressView: UIProgressView, withStatus status: OrderStatus) {
        orderProgressView.translatesAutoresizingMaskIntoConstraints = false
        orderProgressView.progressTintColor = .systemGreen
        orderProgressView.trackTintColor = UIColor(red: 243, green: 242, blue: 247)
        
        let progress: Float
        
        switch status {
        case .processing:
            progress = 0
        case .sent:
            progress = 0.6
        case .delivered:
            progress = 1
        }
        
        orderProgressView.progress = progress
    }
    
    private func setupOrderProgressStatusStackView(_ orderProgressStatusStackView: UIStackView, withStatus status: OrderStatus) {
        orderProgressStatusStackView.axis = .horizontal
        orderProgressStatusStackView.distribution = .equalSpacing
        orderProgressStatusStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let proccesingLabel = UILabel()
        proccesingLabel.setOrderStatusStyle(withText: "Обрабатывается")
        let sentLabel = UILabel()
        sentLabel.setOrderStatusStyle(withText: "Отправлено")
        let deliveredLabel = UILabel()
        deliveredLabel.setOrderStatusStyle(withText: "Доставлено")
        
        let labels = [proccesingLabel, sentLabel, deliveredLabel]
        
        for i in 0...status.rawValue {
            labels[i].textColor = .black
        }
        
        orderProgressStatusStackView.addArrangedSubview(proccesingLabel)
        orderProgressStatusStackView.addArrangedSubview(sentLabel)
        orderProgressStatusStackView.addArrangedSubview(deliveredLabel)
    }
    
    private func createRecomendedBlockView(image: UIImage, mainTitle: String, additionalTitle: String) -> UIView {
        let recomendedBlock = UIView()
        recomendedBlock.translatesAutoresizingMaskIntoConstraints = false
        
        let recomendedImageView = UIImageView(image: image.withConfiguration(UIImage.SymbolConfiguration(pointSize: 40)))
        recomendedImageView.translatesAutoresizingMaskIntoConstraints = false
        recomendedImageView.tintColor = .systemRed
        
        let titleStackView = UIStackView()
        titleStackView.axis = .vertical
        titleStackView.alignment = .top
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.spacing = 5
        
        let mainTitleLabel = UILabel()
        mainTitleLabel.text = mainTitle
        mainTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        mainTitleLabel.textColor = .black
        mainTitleLabel.numberOfLines = 0
        
        let additionalTitleLabel = UILabel()
        additionalTitleLabel.textColor = UIColor(red: 145, green: 145, blue: 144)
        additionalTitleLabel.font = UIFont.systemFont(ofSize: 14)
        additionalTitleLabel.text = additionalTitle
        additionalTitleLabel.numberOfLines = 0
        
        titleStackView.addArrangedSubview(mainTitleLabel)
        titleStackView.addArrangedSubview(additionalTitleLabel)

        let nextButtonImage = UIImageView(image: UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 15)))
        nextButtonImage.translatesAutoresizingMaskIntoConstraints = false
        nextButtonImage.tintColor = UIColor(red: 140, green: 140, blue: 140)
        
        recomendedBlock.addSubview(titleStackView)
        recomendedBlock.addSubview(recomendedImageView)
        recomendedBlock.addSubview(nextButtonImage)
        
        NSLayoutConstraint.activate([
            recomendedBlock.heightAnchor.constraint(equalTo: titleStackView.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            recomendedImageView.topAnchor.constraint(equalTo: recomendedBlock.topAnchor),
            recomendedImageView.leadingAnchor.constraint(equalTo: recomendedBlock.leadingAnchor),
            recomendedImageView.widthAnchor.constraint(equalToConstant: 40),
            recomendedImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            nextButtonImage.trailingAnchor.constraint(equalTo: recomendedBlock.trailingAnchor),
            nextButtonImage.centerYAnchor.constraint(equalTo: recomendedBlock.centerYAnchor),
            nextButtonImage.widthAnchor.constraint(equalToConstant: 10)
        ])
        
        NSLayoutConstraint.activate([
            titleStackView.leadingAnchor.constraint(equalTo: recomendedImageView.trailingAnchor, constant: 30),
            titleStackView.trailingAnchor.constraint(equalTo: nextButtonImage.leadingAnchor, constant: -10),
            titleStackView.topAnchor.constraint(equalTo: recomendedBlock.topAnchor),
        ])
        

        
        
        return recomendedBlock
        
        
    }
    

    

}

extension UILabel {
    func setOrderStatusStyle(withText text: String) {
        self.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        self.textColor = UIColor(red: 154, green: 154, blue: 154)
        self.text = text
    }
}

extension ForYouVC: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                guard let image = reading as? UIImage, error == nil else { return }
                DispatchQueue.main.async {
                    self.avatarImageView.image = image
                }
                self.storageManager.set(image.jpegData(compressionQuality: 0.5), forKey: .avatarPhoto)
                
            }
        }
        picker.dismiss(animated: true)
    }
    
    
}
