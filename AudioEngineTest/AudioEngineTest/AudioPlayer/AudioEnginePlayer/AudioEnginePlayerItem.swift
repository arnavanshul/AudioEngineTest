//
//  AudioEnginePlayerItem.swift
//  AudioEngineTest
//
//  Created by Anshul, Arnav on 10/30/19.
//  Copyright © 2019 Anshul, Arnav. All rights reserved.
//

import UIKit

class AudioEnginePlayerItem: NSObject {
    let url: URL

    required init(with urlToLoad: URL) {
        url = urlToLoad
    }

    func load() {
        let audioStreamDownloader = AudioStreamDownloader(withURL: url)
        audioStreamDownloader.startStreaming()
    }
}
