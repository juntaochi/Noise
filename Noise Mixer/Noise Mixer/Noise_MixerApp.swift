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

        for noise in noiseList{
            noise.volume = noise.loadNoise()!
        }
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
            for noise in noiseList{
                noise.volume = noise.loadNoise()!
            }
        case .inactive:
            
            for noise in noiseList{
                noise.saveNoise()
            }

        case .background:
            
            for noise in noiseList{
                noise.saveNoise()
            }
            
        @unknown default:
            break
        }
    }
}

