//
//  ViewController.swift
//  AudioEngineTest
//
//  Created by Anshul, Arnav on 10/29/19.
//  Copyright © 2019 Anshul, Arnav. All rights reserved.
//

import UIKit

enum Format: String {
    case mp3
    case aac
    case aiff
    case flac
}


class ViewController: UIViewController {
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var playbackProgressView: UIProgressView!

    let fileName = "ff-16b-2c-44100hz"

    static let playLabelTitle = "PLAY"
    static let pauseLabelTitle = "PAUSE"

    let streamingAudio = true
    let playFormat = Format.aac

    var progressMonitor: Timer?

    let audioPlayer = AudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        guard let localFileURL = Bundle.main.url(forResource: fileName, withExtension: playFormat.rawValue) else {
            playPauseButton.isHidden = true
            return
        }

        let streamingURL = URL(string: "https://traffic.megaphone.fm/TTH7630150098.mp3")!

        playbackProgressView.progress = 0.0

        let urlToPlay = streamingAudio ? streamingURL : localFileURL

        audioPlayer.load(urlToPlay)
    }

    @IBAction func playPauseButtonTapped(_ sender: Any) {
        if audioPlayer.isPlaying {
            audioPlayer.pause()
            playPauseButton.setTitle(ViewController.playLabelTitle, for: .normal)
            progressMonitor?.invalidate()
            progressMonitor = nil
        } else {
            audioPlayer.play()
            playPauseButton.setTitle(ViewController.pauseLabelTitle, for: .normal)

            progressMonitor = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] timer in
                guard let strongSelf = self else { return }
                if strongSelf.audioPlayer.duration > 0 {
                    strongSelf.playbackProgressView.progress = Float(strongSelf.audioPlayer.currentPosition) / Float(strongSelf.audioPlayer.duration)
                } else {
                    strongSelf.playbackProgressView.progress = 0
                }
            })

            progressMonitor?.fire()
        }
    }
}

