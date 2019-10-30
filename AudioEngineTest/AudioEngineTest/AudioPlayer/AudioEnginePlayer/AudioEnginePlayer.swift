//
//  AudioEnginePlayer.swift
//  AudioEngineTest
//
//  Created by Anshul, Arnav on 10/30/19.
//  Copyright © 2019 Anshul, Arnav. All rights reserved.
//

import Foundation

class AudioEnginePlayer: NSObject, AudioPlayerInterface {
    func load(_ url: URL) {

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
