//
//  LoadingVC.swift
//  shop
//
//  Created by Евгений Борисов on 09.11.2023.
//

import UIKit

class LoadingVC: UIViewController {
    
    private var timer = Timer()
    
    private lazy var progressView = {
        let progressView = UIProgressView()
        progressView.progressTintColor = .white
        progressView.trackTintColor = .darkGray
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progress = 0
        return progressView
    }()
    
    private lazy var loadingImage = {
        let loadingImage = UIImageView(image: UIImage(named: "aegis"))
        loadingImage.translatesAutoresizingMaskIntoConstraints = false
        loadingImage.contentMode = .scaleAspectFit
        loadingImage.alpha = 0
        return loadingImage
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTimer()
        layout()
    }
    
    private func setupTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
    }
    
    @objc func updateProgress() {
        progressView.progress += 0.1
        UIView.animate(withDuration: 0.3, animations: {
            self.loadingImage.alpha += 0.1
        })
        
        if progressView.progress == 1.0 {
            timer.invalidate()
            let tabBarController = TabBarViewController()
            tabBarController.modalPresentationStyle = .fullScreen
            self.present(tabBarController, animated: true)
        }
    }
    
    private func layout() {
        view.backgroundColor = .black
        self.view.addSubview(progressView)
        self.view.addSubview(loadingImage)
        
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            progressView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            progressView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            loadingImage.bottomAnchor.constraint(equalTo: progressView.topAnchor, constant: -20),
            loadingImage.widthAnchor.constraint(equalTo: progressView.widthAnchor),
            loadingImage.heightAnchor.constraint(equalToConstant: 150),
            loadingImage.centerXAnchor.constraint(equalTo: progressView.centerXAnchor)
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
