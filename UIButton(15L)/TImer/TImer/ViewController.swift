//
//  ViewController.swift
//  TImer
//
//  Created by Евгений Борисов on 25.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var timerLabel = {
        let timerLabel = UILabel()
        timerLabel.font = UIFont(name: "Courier", size: 80)
        timerLabel.adjustsFontSizeToFitWidth = true
        timerLabel.textColor = .black
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        timerLabel.text = "00.00.00"
        return timerLabel
    }()
    
    let startButton = TimerControlButton(imageName: "play.fill")
    let resetButton = TimerControlButton(imageName: "gobackward")
    
    var timer = Timer()
    
    var secondsCount = 0
    var isCounting = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setup()

    }
    
    func setup() {
        setupTimer()
    }
    
    func setupTimer() {
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
    }
    
    @objc func resetButtonTapped() {
        timer.invalidate()
        timerLabel.text = "00.00.00"
        secondsCount = 0
        startButton.setImage(UIImage(systemName: "play.fill", withConfiguration: TimerControlButton.symbolConfiguration), for: .normal)
        isCounting = false
    }
    
    @objc func startButtonTapped() {
        if isCounting {
            timer.invalidate()
            startButton.setImage(UIImage(systemName: "play.fill", withConfiguration: TimerControlButton.symbolConfiguration), for: .normal)
        } else {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerChanged), userInfo: nil, repeats: true)
            startButton.setImage(UIImage(systemName: "pause.fill", withConfiguration: TimerControlButton.symbolConfiguration), for: .normal)
        }
        
        isCounting = !isCounting
    }
    
    @objc func timerChanged() {
        secondsCount += 1
        let time = timeFromSeconds(seconds: secondsCount)
        timerLabel.text = timeToString(time: time)
    }
    
    
    func timeToString(time: (hours: Int, minutes: Int, seconds: Int)) -> String {
        return String(format: "%02d.%02d.%02d", time.hours, time.minutes, time.seconds)
    }
    
    func timeFromSeconds(seconds: Int) -> (hours: Int, minutes: Int, seconds: Int) {
        
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let seconds = (seconds % 3600) % 60
        return (hours, minutes, seconds)
    }
    
    func setupView() {
        view.backgroundColor = .white
        layout()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        startButton.makeRound()
        resetButton.makeRound()
    }
    
    func layout() {
        view.addSubview(timerLabel)
        view.addSubview(startButton)
        view.addSubview(resetButton)
        
     
        
        NSLayoutConstraint.activate([
            timerLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            timerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            timerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            resetButton.topAnchor.constraint(equalToSystemSpacingBelow: timerLabel.bottomAnchor, multiplier: 2),
            resetButton.heightAnchor.constraint(equalToConstant: 80),
            resetButton.widthAnchor.constraint(equalToConstant: 80),
            resetButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 3),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: startButton.trailingAnchor, multiplier: 3),
            startButton.topAnchor.constraint(equalTo: resetButton.topAnchor),
            startButton.heightAnchor.constraint(equalTo: resetButton.heightAnchor, multiplier: 1),
            startButton.widthAnchor.constraint(equalTo: resetButton.widthAnchor, multiplier: 1),
        ])
        
        
    }


}


class TimerControlButton: UIButton {
    
    static var symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 40)
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.lightGray : UIColor.clear
        }
    }
    
    convenience init(imageName: String) {
        self.init()
        configurationWith(imageName: imageName)
    }
    
    func configurationWith(imageName: String) {
        self.setImage(UIImage(systemName: imageName, withConfiguration: TimerControlButton.symbolConfiguration), for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.tintColor = .black
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    func makeRound() {
        self.layer.cornerRadius = 0.5 * self.frame.width
    }
    
}
