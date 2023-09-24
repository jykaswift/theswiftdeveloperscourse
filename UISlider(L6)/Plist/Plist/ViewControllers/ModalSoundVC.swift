//
//  ModalSoundVC.swift
//  Plist
//
//  Created by Евгений Борисов on 22.09.2023.
//

import UIKit
import AVFoundation
class ModalSoundVC: UIViewController {
    
    enum AudioState {
        case play
        case pause
    }
    
    let shareButton = UIButton()
    let hideButton = UIButton()
    let trackImage = UIImageView()
    let controlStackView = UIStackView()
    let sliderStackView = UIStackView()
    let playButton = UIButton()
    let nextButton = UIButton()
    let previousButton = UIButton()
    let shuffleButton = UIButton()
    let audioSlider = UISlider()
    let repeatButton = UIButton()
    let startTimeLabel = UILabel()
    let endTimeLabel = UILabel()
    let trackNameLabel = UILabel()
    let volumeSlider = UISlider()
    var audioController: AudioController!
    var isSliderMoving = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func getColorByRGB(red: Double, green: Double, blue: Double) -> UIColor {
        UIColor( red: CGFloat(red/255.0), green: CGFloat(green/255.0), blue: CGFloat(blue/255.0), alpha: CGFloat(1.0) )
    }
    
    
    func setUpView() {
        view.backgroundColor = getColorByRGB(red: 227, green: 227, blue: 227)
        configureShareButton()
        configureHideButton()
        configureControlButton(button: playButton, withImage: "pause.fill", withSize: 55, withTintColor: .black, withSelector: #selector(playButtonTapped(sender:)))
        configureControlButton(button: previousButton, withImage: "backward.end.fill", withSize: 35, withTintColor: .black, withSelector: #selector(previusButtonTapped))
        configureControlButton(button: nextButton, withImage: "forward.end.fill", withSize: 35, withTintColor: .black, withSelector: #selector(nextButtonTapped))
        configureControlButton(button: shuffleButton, withImage: "shuffle", withSize: 20, withTintColor: .gray)
        configureControlButton(button: repeatButton, withImage: "repeat", withSize: 20, withTintColor: .gray)
        configureVolumeSlider()
        configureControlStackView()
        configureTimeSliderLabels()
        configureAudioSlider()
        configureSliderStackView()
        configureTrackNameLabel()
        configureTrackImage()
        
    }
    
 
    func configureShareButton () {
        view.addSubview(shareButton)
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30)
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up", withConfiguration: largeConfig), for: .normal)
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.tintColor = .gray
        
        NSLayoutConstraint.activate([
            shareButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            shareButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            shareButton.heightAnchor.constraint(equalToConstant: 30),
            shareButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        
    }
    
    @objc func shareButtonTapped() {
        let acitivityController = UIActivityViewController(activityItems: [trackNameLabel.text!], applicationActivities: nil)
        self.present(acitivityController, animated: true)
    }
    
    func configureHideButton() {
        view.addSubview(hideButton)
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30)
        hideButton.setImage(UIImage(systemName: "chevron.down", withConfiguration: largeConfig), for: .normal)
        hideButton.translatesAutoresizingMaskIntoConstraints = false
        hideButton.tintColor = .gray
        
        NSLayoutConstraint.activate([
            hideButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            hideButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            hideButton.heightAnchor.constraint(equalToConstant: 30),
            hideButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        hideButton.addTarget(self, action: #selector(hideButtonTapped), for: .touchUpInside)
    }
    
    @objc func hideButtonTapped() {
        audioController.removeObserver()
        audioController.currentPlayer = nil
        self.dismiss(animated: true)
        
    }
    
    func configureControlButton(
        button: UIButton,
        withImage image: String,
        withSize size: CGFloat,
        withTintColor tintColor: UIColor,
        withSelector selector: Selector? = nil
    ) {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: size)
        button.setImage(UIImage(systemName: image, withConfiguration: imageConfig), for: .normal)
        button.tintColor = tintColor
        if let selector {
            button.addTarget(self, action: selector, for: .touchUpInside)
        }
    }
    
    func togglePlayButtonWith(state: AudioState) {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 55)
        if state == .pause {
            playButton.setImage(UIImage(systemName: "pause.fill", withConfiguration: imageConfig), for: .normal)
            playButton.tag = 0
        } else {
            playButton.setImage(UIImage(systemName: "play.fill", withConfiguration: imageConfig), for: .normal)
            playButton.tag = 1
        }
    }
    
    @objc func playButtonTapped(sender: UIButton) {
        if sender.tag == 0 {
            togglePlayButtonWith(state: .play)
            audioController.pauseSound()
        } else {
            togglePlayButtonWith(state: .pause)
            audioController.playSound()
        }
    }
    
    @objc func nextButtonTapped() {
        let nextTrack = audioController.getTrackInOrder(.next)
        changeTrackWith(track: nextTrack)
    }
    
    @objc func previusButtonTapped() {
        let nextTrack = audioController.getTrackInOrder(.previous)
        changeTrackWith(track: nextTrack)
    }
    
    func configureVolumeSlider() {
        self.view.addSubview(volumeSlider)
        volumeSlider.minimumValueImage = UIImage(systemName: "speaker.minus.fill")
        volumeSlider.maximumValueImage = UIImage(systemName: "speaker.plus.fill")
        volumeSlider.tintColor = .black
        volumeSlider.value = 1
        volumeSlider.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            volumeSlider.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            volumeSlider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            volumeSlider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            volumeSlider.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        volumeSlider.addTarget(self, action: #selector(onVolumeSliderChanged), for: .valueChanged)
        
    }
    
    @objc func onVolumeSliderChanged() {
        audioController.changeVolumeWith(volume: volumeSlider.value)
    }
    
    func configureControlStackView() {
        view.addSubview(controlStackView)
        controlStackView.addArrangedSubview(shuffleButton)
        controlStackView.addArrangedSubview(previousButton)
        controlStackView.addArrangedSubview(playButton)
        controlStackView.addArrangedSubview(nextButton)
        controlStackView.addArrangedSubview(repeatButton)
        controlStackView.axis = .horizontal
        controlStackView.distribution = .equalSpacing
        
        
        controlStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            controlStackView.bottomAnchor.constraint(equalTo: volumeSlider.topAnchor, constant: -30),
            controlStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            controlStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            controlStackView.heightAnchor.constraint(equalToConstant: 55)
        ])
        
    }
    
    func configureAudioSlider() {
        audioSlider.minimumTrackTintColor = .systemGreen
        audioSlider.maximumTrackTintColor = getColorByRGB(red: 196, green: 220, blue: 198)
        let configuration = UIImage.SymbolConfiguration(pointSize: 14)
        let image = UIImage(systemName: "circle.fill", withConfiguration: configuration)
        audioSlider.setThumbImage(image, for: .normal)
        audioSlider.setThumbImage(image, for: .highlighted)
        audioSlider.tintColor = .systemGreen
        
        audioSlider.addTarget(self, action: #selector(onSliderValueChanged(sender:)), for: .touchUpInside)
        audioSlider.addTarget(self, action: #selector(onSliderMoving), for: .valueChanged)
    }
    
    @objc func onSliderMoving() {
        audioController.pauseSound()
        isSliderMoving = true
    }
    
    
    @objc func onSliderValueChanged(sender: UISlider) {
        audioController.setCurrentTimeWith(seconds: sender.value)
        audioController.playSound()
        isSliderMoving = false
    }
    
    func configureTimeSliderLabels() {
        startTimeLabel.textAlignment = .left
        endTimeLabel.textAlignment = .right
        startTimeLabel.font = startTimeLabel.font.withSize(12)
        endTimeLabel.font = startTimeLabel.font.withSize(12)
        startTimeLabel.textColor = .gray
        endTimeLabel.textColor = .gray
    }
    
    func configureSliderStackView() {
        view.addSubview(sliderStackView)
        
        let labelsContainer = getLabelsContainer()
        
        labelsContainer.addArrangedSubview(startTimeLabel)
        labelsContainer.addArrangedSubview(endTimeLabel)
        
        sliderStackView.addArrangedSubview(labelsContainer)
        sliderStackView.addArrangedSubview(audioSlider)
        sliderStackView.axis = .vertical
        sliderStackView.spacing = 10
        
        sliderStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sliderStackView.bottomAnchor.constraint(equalTo: controlStackView.topAnchor, constant: -30),
            sliderStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            sliderStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            sliderStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func getLabelsContainer() -> UIStackView {
        let labelsContainer = UIStackView()
        labelsContainer.distribution = .fillEqually
        labelsContainer.axis = .horizontal
        return labelsContainer
    }
    
    func configureTrackNameLabel() {
        self.view.addSubview(trackNameLabel)
        trackNameLabel.textAlignment = .center
        trackNameLabel.text = "Романс"
        trackNameLabel.font = UIFont(name: "Avenir-Black", size: 18)
        
        trackNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            trackNameLabel.bottomAnchor.constraint(equalTo: sliderStackView.topAnchor, constant: -30),
            trackNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            trackNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            trackNameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func configureTrackImage() {
        view.addSubview(trackImage)
        trackImage.contentMode = .scaleToFill
        trackImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            trackImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            trackImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            trackImage.topAnchor.constraint(equalTo: hideButton.bottomAnchor, constant: 30),
            trackImage.bottomAnchor.constraint(equalTo: trackNameLabel.topAnchor, constant: -30)
        
        ])
    }
    
    private func updateSlider(for time: CMTime) {
        if isSliderMoving { return }
        guard (audioController.currentPlayer?.currentItem?.duration) != nil else { return }
        audioSlider.value = Float(time.seconds)
    }
    
    func changeTrackWith(track: AudioTrack) {
        audioController.removeObserver()
        audioController.setCurrentPlayerWith(track: track)
        
        
        trackImage.image = UIImage(named: track.imageName)
        startTimeLabel.text = "00:00"
        endTimeLabel.text = track.duration
        audioSlider.minimumValue = 0
        audioSlider.maximumValue = track.durationFloat
        audioSlider.value = 0
        
        
        trackNameLabel.text = track.name
        
        audioController.playSound()
        audioController.changeVolumeWith(volume: volumeSlider.value)
        togglePlayButtonWith(state: .pause)
        
        addAudioTimeObserver()
    }
    
    func addAudioTimeObserver() {
        let interval = CMTime(seconds: 1, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        audioController.currentObserver = audioController.currentPlayer?.addPeriodicTimeObserver(forInterval: interval, queue: .main, using: {[self] time in
            if self.audioController.currentPlayer?.currentItem?.status == .readyToPlay {
                self.updateSlider(for: time)
                self.startTimeLabel.text = time.formattedString
                if let duration = audioController.currentPlayer?.currentItem?.duration {
                    let remaining = duration - time
                    self.endTimeLabel.text = "-" + remaining.formattedString
                }
            }
        })
    }
}



extension CMTime {
    
    var formattedString: String {
            let totalSeconds = seconds
            let minutes = Int(totalSeconds.truncatingRemainder(dividingBy: 3600)) / 60
            let seconds = Int(totalSeconds.truncatingRemainder(dividingBy: 60))
            return String(format: "%02d:%02d", minutes, seconds)
        }
    
}

