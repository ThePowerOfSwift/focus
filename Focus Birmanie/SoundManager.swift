//
//  SoundManager.swift
//
//
//  Created by Main Account on 11/3/15.
//  Copyright © 2015 Razeware LLC. All rights reserved.
//


import AVFoundation

public var backgroundMusicPlayer: AVAudioPlayer?
public var soundEffectPlayer: AVAudioPlayer?

    
    let ClICK_MATERIAL = "pop.mp3"
    let BG_WAIT_START = "rangoonMainLoop.mp3"
    let BG_BAGAGES = "sf_hall_aeroport.mp3"
    let BELL = "bell.mp3"
    let BG_BANK = "money.mp3"
    let TAXIS_AEROPORT = "taxisAeroport.mp3"
    let TAXI_ELEPHANT = "taxiElephants.mp3"

//let popMaterial = SKAction.playSoundFileNamed(soundList.ClICK_MATERIAL.rawValue, waitForCompletion: false)

public class SKTAudio {

public func sharedInstance() -> SKTAudio {
    return SKTAudioInstance
}

public func playBackgroundMusic(_ filename: String) {
    let url = Bundle.main.url(forResource: filename, withExtension: nil)
    if (url == nil) {
       
        return
    }
    
    var error: NSError? = nil
    do {
        backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url!)
    } catch let error1 as NSError {
        error = error1
        backgroundMusicPlayer = nil
    }
    if let player = backgroundMusicPlayer {
        player.numberOfLoops = -1
        player.prepareToPlay()
        player.play()
    } else {
 
    }
}

public func pauseBackgroundMusic() {
    if let player = backgroundMusicPlayer {
        if player.isPlaying {
            player.pause()
           
        }
    }
}
    public func stopBackgroundMusic() {
        if let player = backgroundMusicPlayer {
            if player.isPlaying {
               quieter(audioPlayer:player)
            
            }
        }
    }
    func quieter(audioPlayer:AVAudioPlayer) {
        if audioPlayer.volume > 0.1 {
            audioPlayer.volume = audioPlayer.volume - 0.05
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
               self.quieter(audioPlayer:audioPlayer)
                }
            } else {
            audioPlayer.stop()
            
        }
    }
public func resumeBackgroundMusic() {
    if let player = backgroundMusicPlayer {
        if !player.isPlaying {
            player.play()
        }
    }
}

public func playSoundEffect(_ filename: String) {
    let url = Bundle.main.url(forResource: filename, withExtension: nil)
    if (url == nil) {
        print("Could not find file: \(filename)")
        return
    }
    
    var error: NSError? = nil
    do {
        soundEffectPlayer = try AVAudioPlayer(contentsOf: url!)
    } catch let error1 as NSError {
        error = error1
        soundEffectPlayer = nil
    }
    if let player = soundEffectPlayer {
        player.numberOfLoops = 0
        player.prepareToPlay()
        player.play()
    } else {

    }
}
}

private let SKTAudioInstance = SKTAudio()
