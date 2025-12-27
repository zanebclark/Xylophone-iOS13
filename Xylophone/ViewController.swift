//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 28/06/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//
import AVFoundation
import UIKit

func configureAudioSession() {
    // Retrieve the shared audio session.
    let audioSession = AVAudioSession.sharedInstance()
    do {
        // Set the audio session category and mode.
        try audioSession.setCategory(.playback, mode: .default)
        try audioSession.setActive(true)
    } catch {
        print("Failed to set the audio session configuration")
    }
}

class SoundPlayer {
    static let shared = SoundPlayer()
    private var player: AVAudioPlayer?

    func playSound(named name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "wav")
        else {
            print("Sound file not found: \(name)")
            return
        }

        do {
            player = try AVAudioPlayer(
                contentsOf: url,
                fileTypeHint: AVFileType.mp3.rawValue
            )
            player?.prepareToPlay()
            player?.play()
        } catch {
            print("Failed to play sound \(name): \(error.localizedDescription)")
        }
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAudioSession()
    }

    @IBAction func keyPressed(_ sender: UIButton) {
        sender.alpha = 0.5
        let keyLabel = sender.titleLabel?.text
        SoundPlayer.shared.playSound(named: keyLabel!)
        
        //Code should execute after 0.2 second delay.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            //Bring's sender's opacity back up to fully opaque.
            sender.alpha = 1.0
        }
    }
}
