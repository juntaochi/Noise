//
//  Noise.swift
//  Noise Mixer
//John Lucaccioni: joluca@iu.edu
//Juntao Chi: chijun@iu.edu
//Submit date: April 28


import Foundation
import SwiftUI

class Noise : Identifiable, ObservableObject, Equatable{
    
    var volume : Float
    var icon: Image = Image(systemName: "questionmark.square.dashed")
    var color: Color = Color.yellow
    var noiseName: String
    var memorizedVolume: Float
    var noiseView: AnyView?
    static func == (lhs: Noise, rhs: Noise) -> Bool {
        return lhs.noiseName == rhs.noiseName
    }
        
    init(volume: Float = 0.0, icon: Image = Image(systemName: "questionmark.square.dashed"), color: Color = Color.blue, noiseName: String = "NaN", noiseView: AnyView? = nil){
        self.icon = icon
        self.color = color
        self.noiseName = noiseName
        self.memorizedVolume = volume
        self.volume = volume
        self.noiseView = noiseView
    }
    func loadNoise() -> Float? {
        let volumeData = UserDefaults.standard.float(forKey: self.noiseName)
            return volumeData
    }
    
    func saveNoise() {
        UserDefaults.standard.set(volume, forKey: self.noiseName)
    }
}
