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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        guard let localFileURL = Bundle.main.url(forResource: fileName, withExtension: playFormat.rawValue) else {
            playPauseButton.isHidden = true
            return
        }

        playbackProgressView.progress = 0.0
    }

    @IBAction func playPauseButtonTapped(_ sender: Any) {
        print("playPauseButtonTapped")
    }

}

