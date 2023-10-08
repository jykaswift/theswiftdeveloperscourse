//
//  TimerVC.swift
//  Timer
//
//  Created by Евгений Борисов on 03.10.2023.
//

import UIKit

class TimerVC: UIViewController {
    
    let shapeLayer = CAShapeLayer()
    let startButton = UIStopWatchButton(style: .start)
    let cancelButton = UIStopWatchButton(style: .stop)
    let timeView = UIView()
    let timeLabel = UILabel()
    let timeSegmentArray = [Array(0...23), Array(0...59), Array(0...59)]
    let timePickerView = UIPickerView()
    var timeInSeconds = 0
    var isCounting = false
    var isStop = true
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        startButton.addInnerBorder()
        cancelButton.addInnerBorder()
        configureCircleProgressView()
    }
        
    func configureCircleProgressView() {
        
        
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: timeView.bounds.width / 2, y: timeView.bounds.height / 2), radius: (0.5 * timeView.bounds.height) - 10, startAngle: -CGFloat.pi / 2, endAngle:  6*CGFloat.pi / 4, clockwise: true)
        let trackLayer = CAShapeLayer()
        trackLayer.path = circularPath.cgPath
        trackLayer.lineWidth = 10
        trackLayer.strokeColor = UIColor.gray.cgColor
        trackLayer.fillColor = UIColor.clear.cgColor
        
        timeView.layer.addSublayer(trackLayer)
        
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.strokeColor = UIColor.orange.cgColor
        shapeLayer.strokeEnd = 1
        timeView.layer.addSublayer(shapeLayer)
    }
    
    func startTImerAnimation(withDuration duration: Int) {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 0
        basicAnimation.duration = CFTimeInterval(duration)
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
    }
    
    func setUpView() {
        configureUI()
        configureLayout()
        
    }
    
    func configureUI() {
        configurePickerView()
        configureButtons()
        configureTimeView()
    }
    
    func configureTimeView() {
        timeView.disableAutoresizingMask()
        timeView.isHidden = true
        timeLabel.disableAutoresizingMask()
        timeLabel.text = "00.00.00"
        timeLabel.textColor = .white
        timeLabel.font = UIFont(name: "Courier", size: 50)
        timeLabel.textAlignment = .center
        
    }
    
    func configureButtons() {
        startButton.disableAutoresizingMask()
        cancelButton.disableAutoresizingMask()
        
        startButton.setTitle("Start", for: .normal)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.isEnabled = false
        
        startButton.addTarget(self, action: #selector(startButtonTaped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    
    @objc func cancelButtonTapped() {
        timer.invalidate()
        shapeLayer.removeAllAnimations()
        cancelButton.isEnabled = false
        timePickerView.isHidden = false
        timeView.isHidden = true
        isCounting = false
        isStop = true
        startButton.setTitle("Start", for: .normal)
        startButton.setTitleColor(UIColor(red: 52, green: 186, blue: 88), for: .normal)
        startButton.backgroundColor = UIColor(red: 10, green: 42, blue: 20)
    }
    
    @objc func startButtonTaped() {
        
        if isStop {
            let seconds = timeSegmentArray[2][timePickerView.selectedRow(inComponent: 2)]
            let minutes = timeSegmentArray[1][timePickerView.selectedRow(inComponent: 1)]
            let hours = timeSegmentArray[0][timePickerView.selectedRow(inComponent: 0)]
            timeInSeconds = (hours * 3600) + (minutes * 60) + seconds
            timeLabel.text = timeInString(hours: hours, minutes: minutes, seconds: seconds)
            isStop = false
            cancelButton.isEnabled = true
            timePickerView.isHidden = true
            timeView.isHidden = false
        }
        
        if !isCounting {
            startButton.setTitle("Pause", for: .normal)
            startButton.setTitleColor(.systemRed, for: .normal)
            startButton.backgroundColor = UIColor(red: 51, green: 13, blue: 12)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeObserve), userInfo: nil, repeats: true)
            isCounting = true
            startTImerAnimation(withDuration: timeInSeconds)
        } else {
            timer.invalidate()
            shapeLayer.removeAllAnimations()
            isCounting = false
            startButton.setTitle("Resume", for: .normal)
            startButton.setTitleColor(UIColor(red: 52, green: 186, blue: 88), for: .normal)
            startButton.backgroundColor = UIColor(red: 10, green: 42, blue: 20)
            
        }
        

    }
    
    @objc func timeObserve() {
        timeInSeconds -= 1
        if timeInSeconds <= 0 {
            timer.invalidate()
            timeView.isHidden = true
            timePickerView.isHidden = false
            isCounting = false
            cancelButton.isEnabled = false
            isStop = true
            startButton.setTitle("Start", for: .normal)
            startButton.setTitleColor(UIColor(red: 52, green: 186, blue: 88), for: .normal)
            startButton.backgroundColor = UIColor(red: 10, green: 42, blue: 20)
        }
        let time = secondsToHoursMinutesSeconds(timeInSeconds)
        timeLabel.text = timeInString(hours: time.h, minutes: time.m, seconds: time.s)
    }
    
    func timeInString(hours: Int, minutes: Int, seconds: Int) -> String {
        String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    
    
    
    func configurePickerView() {
        timePickerView.disableAutoresizingMask()
        timePickerView.delegate = self
        timePickerView.dataSource = self
        
    }
    
    func configureLayout() {
        view.addSubview(timePickerView)
        view.addSubview(startButton)
        view.addSubview(cancelButton)
        view.addSubview(timeView)
        timeView.addSubview(timeLabel)
        
        NSLayoutConstraint.activate([
            timePickerView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 3),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: timePickerView.trailingAnchor, multiplier: 3),
            timePickerView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 3),
        ])
        
        NSLayoutConstraint.activate([
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: startButton.trailingAnchor, multiplier: 1),
            startButton.topAnchor.constraint(equalTo: timePickerView.bottomAnchor, constant: 20),
            startButton.heightAnchor.constraint(equalToConstant: 100),
            startButton.widthAnchor.constraint(equalToConstant: 100),
        ])
        
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: startButton.topAnchor),
            cancelButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
            cancelButton.heightAnchor.constraint(equalTo: startButton.heightAnchor,multiplier: 1),
            cancelButton.widthAnchor.constraint(equalTo: startButton.widthAnchor, multiplier: 1),
        ])
        
        NSLayoutConstraint.activate([
            timeView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalToSystemSpacingAfter: timeView.trailingAnchor, multiplier: 1),
            timeView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
            timeView.bottomAnchor.constraint(equalTo: startButton.centerYAnchor),
            timeLabel.centerXAnchor.constraint(equalTo: timeView.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: timeView.centerYAnchor)
        ])
        
        
    }
    
    
    func secondsToHoursMinutesSeconds(_ seconds: Int) -> (h: Int, m: Int, s: Int){
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let seconds = (seconds % 3600) % 60
        return (hours, minutes, seconds)
    }


}

extension TimerVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        timeSegmentArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeSegmentArray[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attribut = [NSAttributedString.Key.foregroundColor: UIColor.white]
        return NSAttributedString(string: String(timeSegmentArray[component][row]), attributes: attribut)
    }
    
    
    
    
}
