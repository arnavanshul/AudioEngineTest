//
//  AudioPlayer.swift
//  AudioEngineTest
//
//  Created by Anshul, Arnav on 10/30/19.
//  Copyright © 2019 Anshul, Arnav. All rights reserved.
//

import Foundation

protocol AudioPlayerInterface: NSObjectProtocol {
    func load(_ url: URL)

    func play()

    func pause()

    var duration: TimeInterval{ get }

    var currentPosition: TimeInterval { get }

    var isPlaying: Bool { get }
}

class AudioPlayer: NSObject, AudioPlayerInterface {
    private let useAudioEngine = true

    var internalPlayer: AudioPlayerInterface?

    func load(_ url: URL) {
        if internalPlayer == nil {
            internalPlayer = useAudioEngine ? AudioEnginePlayer() : SimpleEasyPlayer()
        }
        internalPlayer?.load(url)
    }

    func play() {
        internalPlayer?.play()
    }

    func pause() {
        internalPlayer?.pause()
    }

    var duration: TimeInterval {
        internalPlayer?.duration ?? 0
    }

    var currentPosition: TimeInterval {
        internalPlayer?.currentPosition ?? 0
    }

    var isPlaying: Bool {
        return internalPlayer?.isPlaying ?? false
    }
}
