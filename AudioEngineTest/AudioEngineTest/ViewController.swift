//
//  ViewController.swift
//  AudioEngineTest
//
//  Created by Anshul, Arnav on 10/29/19.
//  Copyright © 2019 Anshul, Arnav. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var playbackProgressView: UIProgressView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        playbackProgressView.progress = 0.0
    }

    @IBAction func playPauseButtonTapped(_ sender: Any) {
        print("playPauseButtonTapped")
    }

}

