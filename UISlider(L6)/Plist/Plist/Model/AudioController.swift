//
//  AudioController.swift
//  Plist
//
//  Created by Евгений Борисов on 21.09.2023.
//

import Foundation
import AVFoundation

class AudioController {
    
    enum TrackOrder {
        case previous
        case next
    }
    
    var currentPlayer: AVPlayer?
    var currentObserver: Any?
    var listOfTracks: [AudioTrack] = []
    var tracksCount: Int { listOfTracks.count }
    var currentTrackId = 0
    
    func addAudioTrack(track: AudioTrack) { listOfTracks.append(track) }
    
    func addAudioTrack(withName name: String) {
        let track = AudioTrack(name: name)
        if let track {
            listOfTracks.append(track)
        } else {
            print("No such file")
        }
    }
    
    func changeCurrentTrackId(id: Int) {
        currentTrackId = id
    }
    
    func setCurrentPlayerWith(track: AudioTrack) {
        currentPlayer = AVPlayer(url: track.url)
    }
    
    func removeObserver() {
        if let observer = currentObserver, let player = currentPlayer {
            player.removeTimeObserver(observer)
        }
    }
    
    func changeVolumeWith(volume: Float) {
        currentPlayer?.volume = volume
    }
    
    func getTrackInOrder(_ order: TrackOrder)  -> AudioTrack {
        
        let nextTrackId: Int
        if order == .next {
            nextTrackId = currentTrackId + 1 == listOfTracks.count ? 0 : currentTrackId + 1
        } else {
            nextTrackId = currentTrackId - 1 < 0 ? listOfTracks.count - 1 : currentTrackId - 1
        }
        currentTrackId = nextTrackId
        return listOfTracks[currentTrackId]
    }
    
    func setCurrentTimeWith(seconds: Float) {
        currentPlayer?.currentItem?.seek(to: CMTime(value: CMTimeValue(seconds), timescale: 1), completionHandler: nil)
    }
    
    func playSound() {
        currentPlayer?.play()
    }
    
    func pauseSound() {
        currentPlayer?.pause()
    }
}


