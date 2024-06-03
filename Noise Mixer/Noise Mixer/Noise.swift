//
//  Noise.swift
//  Noise Mixer
//John Lucaccioni: joluca@iu.edu
//Juntao Chi: chijun@iu.edu
//Submit date: April 28


import Foundation
import SwiftUI

class Noise : Identifiable, ObservableObject, Equatable{
//    @Published var currentVolume: Double {
//        didSet {
//            parent?.objectWillChange.send() // Notify the parent that a change occurred
//        }
//    }
//    @Published var memorizedVolume: Double
//    @Published var icon: Image
//    @Published var color: Color
//    @Published var parent: NoiseRepo?
//    @Published var soundEffectName: String
    
    var volume : Float
    var icon: Image = Image(systemName: "questionmark.square.dashed")
    var color: Color = Color.yellow
    var soundEffectName: String
    var memorizedVolume: Float
    static func == (lhs: Noise, rhs: Noise) -> Bool {
        return lhs.soundEffectName == rhs.soundEffectName
    }
    init(volume: Float = 0.0, icon: Image = Image(systemName: "questionmark.square.dashed"), color: Color = Color.blue, soundEffectName: String = "NaN"){
        self.icon = icon
        self.color = color
        self.soundEffectName = soundEffectName
        self.memorizedVolume = volume
        self.volume = volume
        
    }
    
//    func encodeVolume() -> Data? {
//            do {
//                let encoder = JSONEncoder()
//                return try encoder.encode(volume)
//            } catch {
//                print("Error encoding volume: \(error)")
//                return nil
//            }
//        }
//
//        static func decodeVolume(from data: Data) -> Float? {
//            do {
//                let decoder = JSONDecoder()
//                return try decoder.decode(Float.self, from: data)
//            } catch {
//                print("Error decoding volume: \(error)")
//                return nil
//            }
//        }
    
    
    func saveRainNoise() {
            UserDefaults.standard.set(volume, forKey: "rainNoise")
    }
    
    func saveFireNoise() {
            UserDefaults.standard.set(volume, forKey: "fireNoise")
    }
    
    func saveForestNoise() {
            UserDefaults.standard.set(volume, forKey: "forestNoise")
    }
    func saveWaveNosie() {
            UserDefaults.standard.set(volume, forKey: "waveNoise")
    }
    func saveCarNoise(){
        UserDefaults.standard.set(volume, forKey: "carNoise")
    }

    // Retrieve volume from persistent storage
    func loadRain() -> Float? {
        let volumeData = UserDefaults.standard.float(forKey: "rainNoise")
            return volumeData
       
    }
    func loadFire() -> Float? {
        let volumeData = UserDefaults.standard.float(forKey: "fireNoise")
            return volumeData
       
    }
    func loadForest() -> Float? {
        let volumeData = UserDefaults.standard.float(forKey: "forestNoise")
            return volumeData
       
    }
    func loadWave() -> Float? {
        let volumeData = UserDefaults.standard.float(forKey: "waveNoise")
            return volumeData
       
    }
    func loadCar() -> Float? {
        let volumeData = UserDefaults.standard.float(forKey: "carNoise")
            return volumeData
       
    }


//    init(memorizedVolume: Double = 0.0, icon: Image = Image(systemName: "questionmark.square.dashed"), color: Color = Color.blue, soundEffectName: String = "wave") {
//        self.memorizedVolume = memorizedVolume
//        self.currentVolume = memorizedVolume
//        self.icon = icon
//        self.color = color
//        self.soundEffectName = soundEffectName
//    }
}
