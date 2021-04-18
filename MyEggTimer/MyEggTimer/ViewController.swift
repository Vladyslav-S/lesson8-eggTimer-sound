//
//  ViewController.swift
//  MyEggTimer
//
//  Created by MACsimus on 18.04.2021.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes = ["Soft" : 5, "Medium" : 8, "Hard" : 12]
    var secondsPassed = 0
    var totalTime = 0
    var timer = Timer()
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func eggHardness(_ sender: UIButton) {
        
        let hardness = sender.currentTitle!
        
        timer.invalidate()
        progressBar.progress = 1.0
        textLabel.text = "Cooking...\(hardness)"
        progressBar.progress = 0.0
        secondsPassed = 0
        totalTime = eggTimes[hardness]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    @objc func fireTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
        } else {
            timer.invalidate()
            textLabel.text = "Done"
            playSound()
        }
    }

    func playSound () {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player?.play()
    }
}

