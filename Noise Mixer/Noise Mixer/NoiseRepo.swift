//
//  NoiseRepo.swift
//  Noise Mixer
//John Lucaccioni: joluca@iu.edu
//Juntao Chi: chijun@iu.edu
//Submit date: April 28


import Foundation
import SwiftUI
import SwiftData

extension Color {
    static let darkBlue = Color(red: 0.0, green: 0.0, blue: 0.5)
}

var rain = Noise(volume: 0.1,icon:Image(systemName: "cloud.drizzle"),color: .gray, soundEffectName: "rain")
var fire = Noise(volume: 0.1,icon:Image(systemName: "flame"),color: .red, soundEffectName: "fire")
var forest = Noise(volume: 0.3,icon:Image(systemName: "leaf"),color: .green, soundEffectName: "forest")
var wave = Noise(volume: 0.3,icon:Image(systemName: "water.waves"),color: .blue, soundEffectName: "wave")
var car = Noise(volume: 0.3, icon:Image(systemName: "car"), color: .black, soundEffectName: "car")


class NoiseRepo: ObservableObject{
    var noiseList : [Noise]
    
    init() {
        noiseList = []
        noiseList.append(rain)
        noiseList.append(fire)
        noiseList.append(forest)
        noiseList.append(wave)
        noiseList.append(car)

    }
}

//
//  SelectedNoises.swift
//  Noise Mixer
//
//  Created by Lucaccioni, John on 4/27/24.
//

import Foundation
class SelectedNoises: ObservableObject{
    @Published var selectedNoiseList: [Noise]
    
    init() {
        self.selectedNoiseList = [rain, fire, forest, wave]
    }


    func setSelectedNoiseList(_ newList: [Noise]) {
            selectedNoiseList = newList
    }

    
}

