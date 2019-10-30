//
//  AudioEnginePlayer.swift
//  AudioEngineTest
//
//  Created by Anshul, Arnav on 10/30/19.
//  Copyright © 2019 Anshul, Arnav. All rights reserved.
//

import Foundation

class AudioEnginePlayer: NSObject, AudioPlayerInterface {
    var currentItem: AudioEnginePlayerItem? = nil

    func load(_ url: URL) {
        currentItem = AudioEnginePlayerItem(with: url)
        currentItem?.load()
    }

    func play() {

    }

    func pause() {
        
    }

    var duration: TimeInterval {
        return 0
    }

    var currentPosition: TimeInterval {
        return 0
    }

    var isPlaying: Bool {
        return false
    }
}
