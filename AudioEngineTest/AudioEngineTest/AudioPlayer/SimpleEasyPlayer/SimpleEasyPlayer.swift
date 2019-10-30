//
//  SimpleEasyPlayer.swift
//  AudioEngineTest
//
//  Created by Anshul, Arnav on 10/30/19.
//  Copyright © 2019 Anshul, Arnav. All rights reserved.
//

import Foundation
import AVFoundation

class SimpleEasyPlayer: NSObject, AudioPlayerInterface {
    let avPlayer = AVPlayer()
    var currentItem: AVPlayerItem? = nil

    func load(_ url: URL) {
        currentItem = AVPlayerItem(url: url)
        avPlayer.replaceCurrentItem(with: currentItem)
    }

    func play() {
        avPlayer.play()
    }

    func pause() {
        avPlayer.pause()
    }

    var duration: TimeInterval {
        guard let currentItem = currentItem else { return 0 }

        return CMTimeGetSeconds(currentItem.duration)
    }

    var currentPosition: TimeInterval {
        guard let currentItem = currentItem else { return 0 }
        return CMTimeGetSeconds(currentItem.currentTime())
    }

    var isPlaying: Bool {
        guard let _ = currentItem else { return false }
        return avPlayer.timeControlStatus == .playing
    }
    
}
