//
//  AudioPlayerManager.swift
//  Noise Mixer
//John Lucaccioni: joluca@iu.edu
//Juntao Chi: chijun@iu.edu
//Submit date: April 28


import UIKit
import AVFoundation
class AudioPlayerManager: NSObject {
    
    struct PlayerInfo{
        let player: AVAudioPlayer
        var noise: Noise
        
    }
    
    var players: [PlayerInfo] = []
    
    
    override init(){
        super.init()
        do{
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch{
            print("Error settting up audio session.")
        }
    }
    func playSound(with noise: Noise) {
        if let existingPlayer = players.first(where: { $0.noise.noiseName == noise.noiseName }) {
            // If a player exists, play it
            existingPlayer.player.play()
            return
        }
        guard let folderURL = Bundle.main.url(forResource: "audioSounds", withExtension: nil) else {
            print("Sound file not found")
            return
        }
        let fileURL = folderURL.appendingPathComponent(noise.noiseName).appendingPathExtension("mp3")
        
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            print("Sound file not found at :\(fileURL)")
            return
        }
        do {
            let player = try AVAudioPlayer(contentsOf: fileURL)
            player.prepareToPlay()
            player.numberOfLoops = -1  // Loop indefinitely
            player.volume = 0
            player.play()
            let playerInfo = PlayerInfo(player: player, noise: noise)
            players.append(playerInfo)
            
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    func printAllPlayers() {
        for playerInfo in players {
            print("Player: \(playerInfo.player)")
            print("Noise: \(playerInfo.noise.noiseName)")
        }
    }

    func adjustVolume(for noise: Noise, to volume: Float){
        guard let playerInfo = players.first(where: {$0.noise.noiseName == noise.noiseName})
        else {
            print("No player found for noise: \(noise)")
            return
        }
        
        playerInfo.player.volume = volume
//        print("player volume: \(playerInfo.player.volume)")
//        print("Player noise: \(playerInfo.noise.soundEffectName)")
//        playerInfo.player.play()
    }
    func stopPlayer(for noise: Noise){
        guard let playerInfo = players.first(where: {$0.noise.noiseName == noise.noiseName})
        else {
            print("No player found for noise: \(noise)")
            return
        }
        playerInfo.player.stop()

    }
    

}

