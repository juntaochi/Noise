//
//  Noise_MixerApp.swift
//  Noise Mixer
//John Lucaccioni: joluca@iu.edu
//Juntao Chi: chijun@iu.edu
//Submit date: April 28

import SwiftUI
let sharedNoiseRepo = NoiseRepo()
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let noiseList = sharedNoiseRepo.noiseList
//        for noise in noiseList{
//            noise.volume = 1
//            noise.saveVolumeToPersistentStorage()
//        }
        noiseList[0].volume = noiseList[0].loadFire()!
        noiseList[1].volume = noiseList[1].loadRain()!
        noiseList[2].volume = noiseList[2].loadForest()!
        noiseList[3].volume = noiseList[3].loadWave()!

//        for noise in noiseList{
//            if let saved_volume = noise.loadVolumeFromPersistentStorage(){
//                
//                noise.volume = saved_volume
//                print("In AppDelegate, Noise: \(noise.soundEffectName), volume: \(noise.volume) ")
//            }
//            
//        }
        
        return true
    }
}

@main
struct Noise_MixerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var noiseRepo = sharedNoiseRepo
    @Environment(\.scenePhase) private var scenePhase
    @StateObject var selectedNoises = SelectedNoises()
    @StateObject var isChecked = IsChecked()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(noiseRepo)
                .environmentObject(selectedNoises)
                .environmentObject(isChecked)
            
        }.onChange(of: scenePhase) { newScenePhase in
            handleSceneChange(newScenePhase)
        }
    }
    
    func handleSceneChange(_ newScenePhase: ScenePhase) {
        let noiseList = noiseRepo.noiseList
        
        switch newScenePhase{
            
        case .active:
            noiseList[0].volume = noiseList[0].loadFire()!
            noiseList[1].volume = noiseList[1].loadRain()!
            noiseList[2].volume = noiseList[2].loadForest()!
            noiseList[3].volume = noiseList[3].loadWave()!
        case .inactive:

            noiseList[0].saveFireNoise()
            noiseList[1].saveRainNoise()
            noiseList[2].saveForestNoise()
            noiseList[3].saveWaveNosie()
//            for noise in noiseList{
//                print("Noise: \(noise.soundEffectName) saved volume: \(noise.volume)")
//                noise.saveVolumeToPersistentStorage()
//            }
        case .background:
//            for noise in noiseList{
//                print("Noise: \(noise.soundEffectName) saved volume: \(noise.volume)")
//                noise.saveVolumeToPersistentStorage()
//            }
            noiseList[0].saveFireNoise()
            noiseList[1].saveRainNoise()
            noiseList[2].saveForestNoise()
            noiseList[3].saveWaveNosie()
            
        @unknown default:
            break
            
            
        }
    }
}

