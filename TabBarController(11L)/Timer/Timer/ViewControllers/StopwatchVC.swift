//
//  StopwatchVC.swift
//  Timer
//
//  Created by Евгений Борисов on 03.10.2023.
//

import UIKit

class StopwatchVC: UIViewController {
    
    let timeLabel = UILabel()
    let startButton = UIStopWatchButton()
    let lapButton = UIStopWatchButton()
    var timer = Timer()
    var isCounting = false
    var count: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView() {
        configureUI()
        configureLayout()
        
    }
    
    func configureUI() {
        configureTimeLabel()
        configureStartButton()
        configureLapButton()
    }
    
    func configureLapButton() {
        lapButton.disableAutoresizingMask()
        lapButton.setTitle("Lap", for: .normal)
        lapButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        lapButton.setTitleColor(.white, for: .normal)
        lapButton.backgroundColor = .lightGray
        lapButton.isEnabled = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        startButton.layer.cornerRadius = 0.5 * startButton.bounds.size.width
        startButton.clipsToBounds = true
        startButton.layer.innerBorder(borderOffset: 2, borderColor: .black, borderWidth: 2)
        lapButton.layer.cornerRadius = 0.5 * lapButton.bounds.size.width
        lapButton.clipsToBounds = true
        lapButton.layer.innerBorder(borderOffset: 2, borderColor: .black, borderWidth: 2)
    }
    
    func configureStartButton() {
        startButton.disableAutoresizingMask()
        startButton.setTitle("Start", for: .normal)
        startButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        startButton.setTitleColor(UIColor(red: 52, green: 186, blue: 88), for: .normal)
        startButton.backgroundColor = UIColor(red: 10, green: 42, blue: 20)
        startButton.addTarget(self, action: #selector(startButtunTapped), for: .touchUpInside)
    }
    
    @objc func startButtunTapped(target: UIButton) {
        
        if !isCounting {
            startButton.setTitleColor(.systemRed, for: .normal)
            startButton.setTitle("Stop", for: .normal)
            startButton.backgroundColor = UIColor(red: 51, green: 13, blue: 12)
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerChanged), userInfo: nil, repeats: true)
        } else {
            timer.invalidate()
            startButton.setTitle("Start", for: .normal)
            startButton.setTitleColor(UIColor(red: 52, green: 186, blue: 88), for: .normal)
            startButton.backgroundColor = UIColor(red: 10, green: 42, blue: 20)
        }
        
        isCounting = !isCounting
        
    }
    
    @objc func timerChanged() {
        count += 0.01
        let timings = milisecondToSecondsAndMinutes(milisecond: count)
        timeLabel.text = String(format: "%02d:%02d:%02d", timings.minutes, timings.seconds, timings.miliseconds)
        
    }
    
    func milisecondToSecondsAndMinutes(milisecond: Double) -> (minutes: Int, seconds: Int, miliseconds: Int) {
        let seconds = Int(milisecond)
        let currentMinutes = seconds / 60
        let currentSeconds = (seconds % 60)
        let miliseconds = Int(milisecond.truncatingRemainder(dividingBy: 1) * 100)
        return (currentMinutes, currentSeconds, miliseconds)
    }
    
    func configureTimeLabel() {
        timeLabel.text = "00.00.00"
        timeLabel.textColor = .white
        timeLabel.font = UIFont(name: "Courier", size: 100)
        timeLabel.adjustsFontSizeToFitWidth = true
        timeLabel.minimumScaleFactor = 0.1
        timeLabel.textAlignment = .center

        timeLabel.disableAutoresizingMask()
    }
    
    func configureLayout() {
        
        view.addSubview(timeLabel)
        view.addSubview(startButton)
        view.addSubview(lapButton)
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 8),
            timeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: timeLabel.trailingAnchor, multiplier: 1),
        ])
        
        NSLayoutConstraint.activate([
            startButton.trailingAnchor.constraint(equalTo: timeLabel.trailingAnchor),
            startButton.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 20),
            startButton.heightAnchor.constraint(equalToConstant: 100),
            startButton.widthAnchor.constraint(equalToConstant: 100),
        ])
        
        NSLayoutConstraint.activate([
            lapButton.topAnchor.constraint(equalTo: startButton.topAnchor),
            lapButton.leadingAnchor.constraint(equalTo: timeLabel.leadingAnchor),
            lapButton.heightAnchor.constraint(equalTo: startButton.heightAnchor,multiplier: 1),
            lapButton.widthAnchor.constraint(equalTo: startButton.widthAnchor, multiplier: 1),
        ])
        
    }
    
}

extension CALayer {
    func innerBorder(borderOffset: CGFloat = 24.0, borderColor: UIColor = UIColor.blue, borderWidth: CGFloat = 2) {
        let innerBorder = CALayer()
        innerBorder.frame = CGRect(x: borderOffset, y: borderOffset, width: frame.size.width - 2 * borderOffset, height: frame.size.height - 2 * borderOffset)
        innerBorder.borderColor = borderColor.cgColor
        innerBorder.borderWidth = borderWidth
        innerBorder.cornerRadius = 0.5 * innerBorder.bounds.width
        innerBorder.name = "innerBorder"
        insertSublayer(innerBorder, at: 0)
    }
}

class UIStopWatchButton: UIButton {
    
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? backgroundColor?.withAlphaComponent(0.6) : backgroundColor?.withAlphaComponent(1)
        }
    }
    
    open override var isEnabled: Bool{
        didSet {
            alpha = isEnabled ? 1.0 : 0.6
        }
    }
}
