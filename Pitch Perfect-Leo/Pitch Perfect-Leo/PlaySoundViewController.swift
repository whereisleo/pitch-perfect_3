//
//  PlaySoundViewController.swift
//  Pitch Perfect-Leo
//
//  Created by Leonardo Martinez on 3/16/15.
//  Copyright (c) 2015 LooseMonkey. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    
    var audioPlayerForEcho: AVAudioPlayer!
    
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playAudio() {
        
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        
        audioEngine.stop()
        audioEngine.reset()
        
        playAudio()
        audioPlayer.rate = 0.5
        
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        
        audioEngine.stop()
        audioEngine.reset()
        
        playAudio()
        audioPlayer.rate = 1.5
        
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        
        playAudioWithVariablePitch(1000)

    }

    func playAudioWithVariablePitch(pitch: Float){
        
        stopPlayback()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
        
    }
    
    @IBAction func playDartVaderAudio(sender: UIButton) {
        
        playAudioWithVariablePitch(-1000)
        
    }
    
    @IBAction func playEchoAudio(sender: UIButton) {
        
        
        stopPlayback()

        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        
        //A.1***
        var echoDelay = AVAudioUnitDelay()
        echoDelay.delayTime = NSTimeInterval(0.25)
        audioEngine.attachNode(echoDelay)
        audioEngine.connect(audioPlayerNode, to: echoDelay, format: nil )
        audioEngine.connect(echoDelay, to: audioEngine.outputNode, format: nil )
     
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    func stopPlayback(){
        
        audioPlayer.stop()
        
        audioEngine.stop()
        audioEngine.reset()
        
    }
    
    
    @IBAction func stopAudio(sender: UIButton) {
        
        stopPlayback()
        
    }
    
    
}

//A.1- From line 116-120, I used Muneeb_rama's suggested code to add the echo effec
//     http://discussions.udacity.com/t/adding-exceeds-specifications-echo-effect/12929/3


































