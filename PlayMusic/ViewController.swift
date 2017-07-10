//
//  ViewController.swift
//  PlayMusic
//
//  Created by Kien Nguyen Duc on 7/4/17.
//  Copyright © 2017 Kien Nguyen. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController, AVAudioPlayerDelegate {
    var isPlay = false
    
    @IBOutlet weak var outletRepeat: UISwitch!
    
    @IBAction func checkRepeat(_ sender: Any) {
        if outletRepeat.isOn == true {
            audio.numberOfLoops = -1
        }
        else {
            audio.numberOfLoops = 0
        }
        
    }
    
    @IBOutlet weak var lbl_Timeleft: UILabel!
    
    @IBOutlet weak var lbl_TimeTotal: UILabel!
    
    @IBOutlet weak var sld_Duration: UISlider!
    
    
    @IBOutlet weak var btn_Play: UIButton!
    var audio = AVAudioPlayer()
    
    @IBAction func slider_Volume(_ sender: UISlider) {
        audio.volume = sender.value
        print(sender.value)
    }
    
    @IBAction func action_Play(_ sender: Any) {
        if isPlay == true{
            audio.pause()
            btn_Play.setBackgroundImage(#imageLiteral(resourceName: "play"), for: UIControlState.normal)
            isPlay = false
        }
        else {
            audio.play()
            btn_Play.setBackgroundImage(#imageLiteral(resourceName: "pause"), for: UIControlState.normal)
            isPlay = true
        }
    }
    
    @IBOutlet weak var slider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audio = try! AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: Bundle.main.path(forResource: "anhmuon", ofType: "mp3")!) as URL)
        addThumbImageforSlider()
        sld_time()
        audio.delegate = self
        _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimeLeft), userInfo: nil, repeats: true)
    }
    
    func updateTimeLeft() {
        self.lbl_Timeleft.text = String(format: "%2.2f" , audio.currentTime/60)
        self.sld_Duration.value = Float(audio.currentTime/audio.duration)
        self.lbl_TimeTotal.text = String(format: "%2.2f", audio.duration/60)
        
    }
    
    
    
    
    func addThumbImageforSlider() {
        slider.setThumbImage(UIImage(named:"thumb.png"), for: .normal)
        slider.setThumbImage(UIImage(named:"thumbHightLight.png"), for: .highlighted)
    }
    
    // Khi kết thúc bài hát
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool){
        btn_Play.setBackgroundImage(#imageLiteral(resourceName: "play"), for: UIControlState.normal)
    }
    
    func sld_time() {
        sld_Duration.setThumbImage(UIImage(named: "duration.png"), for: .normal)
        sld_Duration.value = 0
        
    }
    
}

