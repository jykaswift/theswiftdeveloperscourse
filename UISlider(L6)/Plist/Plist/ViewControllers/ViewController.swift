//
//  ViewController.swift
//  Plist
//
//  Created by Евгений Борисов on 21.09.2023.
//

import UIKit

class ViewController: UIViewController {
    let titleLabel = UILabel()
    var trackViews: [UIView] = []
    
    let audioController = AudioController()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        audioController.addAudioTrack(withName: "улыбка")
        audioController.addAudioTrack(withName: "романс")
        setupView()
        
    }
    
    func setupView() {
        configureTitleLable()
        addTrackViews()
    }
    
    func addTrackViews() {
        for (tag, track) in audioController.listOfTracks.enumerated() {
            addTrackViewWith(track: track, andTag: tag)
        }
    }
    
    func configureTitleLable() {
        view.addSubview(titleLabel)
        titleLabel.text = "Plist"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = titleLabel.font.withSize(24)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    func addTrackViewWith(track: AudioTrack, andTag tag: Int) {
        let trackView = UIView()
        trackView.tag = tag
        let trackImageView = UIImageView()
        let trackNameLabel = UILabel()
        let trackDurationLabel = UILabel()
        trackView.addSubview(trackImageView)
        trackView.addSubview(trackNameLabel)
        trackView.addSubview(trackDurationLabel)
        self.view.addSubview(trackView)
        
        
        configureTrackView(trackView)
        configureTrackImageView(trackImageView, withImageName: track.imageName)
        configureTrackNameLabel(trackNameLabel, withName: track.name)
        configuteTrackDurationLabel(trackDurationLabel, withDuration: track.duration)
        trackViews.append(trackView)

    }
    
    func configuteTrackDurationLabel(_ label: UILabel, withDuration duration: String) {
        label.text = duration
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        
        guard let superview = label.superview else {
            return
        }
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: superview.topAnchor, constant: 18),
            label.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: 0),
            label.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        
        
    }
    
    func configureTrackNameLabel(_ trackNameLabel: UILabel, withName name: String) {
        
        trackNameLabel.translatesAutoresizingMaskIntoConstraints = false
        trackNameLabel.text = name
        trackNameLabel.textColor = .black
        trackNameLabel.font = UIFont(name: "Avenir-Black", size: 18)
        
        guard let superview = trackNameLabel.superview else {
            return
        }
        
        NSLayoutConstraint.activate([
            trackNameLabel.topAnchor.constraint(equalTo: superview.topAnchor, constant: 17),
            trackNameLabel.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 70),
            trackNameLabel.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -50)
        ])
        
    }
    
    func configureTrackImageView(_ imageView: UIImageView, withImageName imageName: String) {
        guard let superview = imageView.superview else {
            return
        }
        imageView.image = UIImage(named: imageName) ?? UIImage(systemName: "music.note")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: superview.topAnchor, constant: 0),
            imageView.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 0),
            imageView.widthAnchor.constraint(equalToConstant: 60),
            imageView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func configureTrackView(_ trackView: UIView) {
        trackView.addBottomBorder()
        trackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            trackView.heightAnchor.constraint(equalToConstant: 70),
            trackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            trackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
        
        if trackViews.isEmpty {
            trackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        } else {
            let lastTrackView = trackViews.last!
            trackView.topAnchor.constraint(equalTo: lastTrackView.bottomAnchor, constant: 20).isActive = true
        }
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(trackViewTapped(sender:)))
       trackView.addGestureRecognizer(tapRecognizer)
    }
    
 
    
    @objc func trackViewTapped(sender: UITapGestureRecognizer) {
        let modalSoundVC = ModalSoundVC()
        let track = audioController.listOfTracks[sender.view!.tag]
        modalSoundVC.audioController = audioController
        modalSoundVC.presentationController?.delegate = self
        audioController.changeCurrentTrackId(id: sender.view!.tag)
        self.present(modalSoundVC, animated: true)
        modalSoundVC.changeTrackWith(track: track)
    }

}

extension UIView {
    func addBottomBorder() {
        let border = UIView()
        self.addSubview(border)
        
        border.translatesAutoresizingMaskIntoConstraints = false
        border.backgroundColor = .gray
        
        NSLayoutConstraint.activate([
            border.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            border.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            border.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            border.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}

extension ViewController: UIAdaptivePresentationControllerDelegate {
      public func presentationControllerDidDismiss( _ presentationController: UIPresentationController) {
          audioController.removeObserver()
          audioController.currentPlayer = nil
      }
  }
