//
//  NoiseRepo.swift
//  Noise Mixer
//John Lucaccioni: joluca@iu.edu
//Juntao Chi: chijun@iu.edu
//Submit date: April 28


import Foundation
import SwiftUI
import SwiftData

var rain = Noise(volume: 1.0,icon:Image(systemName: "cloud.drizzle"),color: .gray, noiseName: "rain", noiseView: AnyView(RainView()))
var fire = Noise(volume: 0.0,icon:Image(systemName: "flame"),color: .red, noiseName: "fire", noiseView: AnyView{FireView()})
var forest = Noise(volume: 0.0,icon:Image(systemName: "leaf"),color: .green, noiseName: "forest")
var wave = Noise(volume: 0.0,icon:Image(systemName: "water.waves"),color: .blue, noiseName: "wave")
var car = Noise(volume: 0.0, icon:Image(systemName: "car"), color: .black, noiseName: "car")


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

