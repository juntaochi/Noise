//
//  mixerView.swift
//  Noise Mixer
//John Lucaccioni: joluca@iu.edu
//Juntao Chi: chijun@iu.edu
//Submit date: April 28


import SwiftUI
var audioManager = AudioPlayerManager()
struct littleSquare : View {
    
    let squareWidth = UIScreen.main.bounds.width/2.5
    var noise: Noise
    @State private var slideValue: CGFloat = 0.0
    @State private var lastV: CGFloat = 0.0
    @EnvironmentObject var selectedNoises: SelectedNoises

    var body: some View {
        ZStack{
            Rectangle()
                .fill(.clear)
                .frame(width: squareWidth, height: squareWidth)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20.0))
                .opacity(0.2)
                .shadow(color: .black.opacity(0.3),radius: 2)

            Rectangle()
                .fill(.black.opacity(0.15))
                .frame(width: squareWidth, height: squareWidth)
                .offset(y:slideValue)
                .animation(.smooth(duration: 0.27), value: slideValue)
                .mask {
                    RoundedRectangle(cornerRadius: 20.0)
                        .frame(width: squareWidth, height: squareWidth)
                }
            noise.icon
                .font(.system(size: 50))
                .foregroundColor(.white.opacity(0.37))
            
            RoundedRectangle(cornerRadius: 20.0)
                .fill(.clear)
                .frame(width: squareWidth, height: squareWidth)
                .contentShape(Rectangle())
            
                //When tapped volume goes to zero, when tapped again it goes back to previous volume
                .gesture(
                    TapGesture()
                        .onEnded { _ in
                            print("tapped")
                            if noise.volume <= 0.0{
                                if noise.memorizedVolume <= 0.0{
                                    noise.volume = 1.0
                                    audioManager.adjustVolume(for: noise, to: noise.volume)
                                }else{
                                    noise.volume = noise.memorizedVolume
                                    audioManager.adjustVolume(for: noise, to: noise.volume)
                                }
                                slideValue = (1.0-CGFloat(noise.volume))*squareWidth
                                
                            }else if noise.volume > 0.0 {
                                noise.memorizedVolume = noise.volume
                                slideValue = squareWidth
                                noise.volume = Float(1.0-(slideValue/squareWidth))//should be 0.0
                                audioManager.adjustVolume(for: noise, to: noise.volume)
                            }
                        }
                )
                .highPriorityGesture(DragGesture(minimumDistance: 1)
                    .onChanged{ v in
                        if v.translation.height != 0 {
                            slideValue = slideValue - lastV + v.translation.height
                            //print("\( v.translation.height) - \(lastV) = \(v.translation.height - lastV)")
                        }
                        lastV = v.translation.height
                        if slideValue <= 0{
                            slideValue = 0
                        }else if slideValue >= squareWidth{
                            slideValue = squareWidth
                        }
                        noise.volume = Float(1-(slideValue/squareWidth))
                        audioManager.adjustVolume(for: noise, to: noise.volume)
                    }.onEnded{_ in 
                        lastV = 0
                    }
                )
        }.onAppear() {
            slideValue = CGFloat((1 - noise.volume)) * squareWidth
            lastV = 0
            audioManager.playSound(with: noise)
            audioManager.adjustVolume(for: noise, to: noise.volume)
        }
        .onChange(of: selectedNoises.selectedNoiseList){ selectedNoiseList in
                    slideValue = CGFloat((1 - noise.volume)) * squareWidth
                    lastV = 0
                    audioManager.playSound(with: noise)
                    audioManager.adjustVolume(for: noise, to: noise.volume)
        }
    }
}
struct mixerView: View {
    @EnvironmentObject var noiseRepo: NoiseRepo
    @EnvironmentObject var selectedNoises: SelectedNoises
    var body: some View {
        
        VStack{
            Spacer()
            Spacer()
            HStack{
                Text("Welcome back.")
                    .fontWeight(.thin)
                    .padding(30)
                    .shadow(radius: 2).opacity(0.6)
                    .font(.title)
                    .foregroundColor(.black.opacity(0.7))
                    .multilineTextAlignment(.leading)
                    Spacer()
            }
            Spacer()
            Spacer()
            VStack{
                VStack{
                    HStack{
                        Spacer()
                        Spacer()

                        littleSquare(noise: selectedNoises.selectedNoiseList[0])

                        Spacer()
                        littleSquare(noise: selectedNoises.selectedNoiseList[1])

                        Spacer()
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        Spacer()
                        littleSquare(noise: selectedNoises.selectedNoiseList[2])

                        Spacer()
                        littleSquare(noise: selectedNoises.selectedNoiseList[3])
                        
                        Spacer()
                        Spacer()
                        
                    }
                }.onChange(of: selectedNoises.selectedNoiseList){ selectedNoiseList in
                    for noise in noiseRepo.noiseList{
                        var isSelected = false
                        for selectedNoise in selectedNoises.selectedNoiseList {
                            if noise.soundEffectName == selectedNoise.soundEffectName{
                                isSelected = true
                            }
                        }
                        if isSelected == false{
                            audioManager.stopPlayer(for: noise)
                        }
                    }
                }
                
            }
            Spacer()
            Spacer()
            Spacer()
        }
    }
}

#Preview {
    mixerView().environmentObject(NoiseRepo())
}
