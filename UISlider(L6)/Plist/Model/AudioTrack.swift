//
//  AudioTrack.swift
//  Plist
//
//  Created by Евгений Борисов on 21.09.2023.
//

import Foundation
import AVFoundation

class AudioTrack {
    
    var name: String
    var path: String!
    var imageName = ""
    var url: URL { URL(filePath: path) }
    
    lazy var duration = {
        do {
            let audioPlayer = try AVAudioPlayer(contentsOf: url)
            return audioPlayer.stringDuration
        } catch {
            assertionFailure("Failed crating audio player: \(error).")
            return ""
        }
    }()
    
    lazy var durationFloat = {
        do {
            let audioPlayer = try AVAudioPlayer(contentsOf: url)
            return Float(audioPlayer.duration)
        } catch {
            assertionFailure("Failed crating audio player: \(error).")
            return 0.0
        }
    }()
    
    init?(name: String) {
        self.name = name.capitalized
        self.imageName = name
        if let path = getPathByName(name: name) {
            self.path = path
        } else {
            return nil
        }
    }

    init(name: String, path: String, imageName: String) {
        self.name = name
        self.path = path
        self.imageName = imageName
    }
    
    func getPathByName(name: String) -> String? {
        Bundle.main.path(forResource: name, ofType: "mp3")
    }
}


extension AVAudioPlayer {
    var stringDuration: String {
        let intDuration = Int(duration)
        let minutes = intDuration / 60
        let seconds = intDuration % 60
        let stringMinutes = minutes < 10 ? "0\(minutes)" : String(minutes)
        let stringSeconds = seconds < 10 ? "0\(seconds)" : String(seconds)
        return stringMinutes + ":" + stringSeconds
    }
}
