//
//  ContentView.swift
//  Noise Mixer
//John Lucaccioni: joluca@iu.edu
//Juntao Chi: chijun@iu.edu
//Submit date: April 28


import SwiftUI
import AVFoundation

struct ContentView: View {
    @EnvironmentObject var noiseRepo: NoiseRepo
    @State private var showMixer = true
    @State private var isMenuPresented = false

    var body: some View {
        ZStack {
            
            ZenView()
            mixerView()
                .opacity(showMixer ? 1 : 0)
                .animation(.smooth(duration: 0.4),value: showMixer)
            VStack{
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                HStack{
                    Text("Zen Mode")
                        .foregroundColor(.white.opacity(showMixer ? 0.1 : 0.32))
                        .padding(30)
                        .background(.clear)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            showMixer.toggle()
                        }
                        .animation(.smooth(duration: 0.2),value: showMixer)
                    Spacer()
                    Text("Select Noises")
                        .foregroundColor(.white.opacity(isMenuPresented ? 0.1 : 0.32))
                        .padding(30)
                        .background(.clear)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            isMenuPresented.toggle()
                        }
                        .sheet(isPresented: $isMenuPresented) {
                            selectionView()
                        }
                }
                Spacer()

            }
        }


        
    }

}

    

struct ContentnView_Previews: PreviewProvider {
    static var previews: some View {
        let noiseRepo = NoiseRepo()
        let selectedNoises = SelectedNoises()
                
        ContentView()
            .environmentObject(noiseRepo)
            .environmentObject(selectedNoises)
    }
}
