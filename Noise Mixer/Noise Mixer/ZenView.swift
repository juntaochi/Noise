//
//  SwiftUIView.swift
//  Noise Mixer
//John Lucaccioni: joluca@iu.edu
//Juntao Chi: chijun@iu.edu
//Submit date: April 28


import SwiftUI
import CoreGraphics
import UIKit
struct ZenView: View {
    @EnvironmentObject var noiseRepo: NoiseRepo
    @EnvironmentObject var selectedNoises: SelectedNoises
    let startDate : Date = .init()// the time of the moment this code runs
    var body: some View {
        ZStack{
            Rectangle()
                .fill(.black)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                    .opacity(0.3)
                TimelineView(.animation){
                    let time = $0.date.timeIntervalSince1970 - startDate.timeIntervalSince1970//interval of line "let startDate : Date = .init()" executing time to realtime
                    if #available(iOS 17.0, *) {
                        ZStack{
                            ZStack {
                                Image("background")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                                    .opacity(0.3)
                                Image("background")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                                    .opacity(Double(self.selectedNoises.selectedNoiseList[2].volume))
                                    .animation(.smooth(duration: 3), value: self.selectedNoises.selectedNoiseList[2].volume)
                            }//wave effect
                                .distortionEffect(.init(function: .init(library: .default, name: "wave"), arguments:[
                                    .float(time),
                                    .float(1),//speed
                                    .float(200),//frequency
                                    .float(150 * self.selectedNoises.selectedNoiseList[3].volume + 1)//amplitude
                                ]), maxSampleOffset: .zero)
                            ForEach(selectedNoises.selectedNoiseList) { noise in  //rain and fire is here
                                let view = noise.noiseView
                                view
                                    .opacity(Double(noise.volume))
                                    .animation(.smooth(duration: 3), value: noise.volume)
                            }
                            
                        }
                    } else {
                        // Fallback on earlier versions
                        ZStack {
                            Image("background")
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                                .opacity(0.3)
                            Image("background")
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
                                .opacity(Double(self.selectedNoises.selectedNoiseList[2].volume))
                                .animation(.smooth(duration: 3), value: self.selectedNoises.selectedNoiseList[2].volume)
                        }
                    }
                }
                
            }
            VisualEffectView(effect: UIBlurEffect(style: .light))
        }
        .blur(radius: 40)
        .ignoresSafeArea()
//        .background(.black)
        .background(Color(red: 101/255, green: 168/255, blue: 56/255))
    }

    struct VisualEffectView: UIViewRepresentable {
        var effect: UIVisualEffect?
        func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
        func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
    }
}

struct ZenView_Previews: PreviewProvider {
    static var previews: some View {
        let noiseRepo = NoiseRepo()
        let selectedNoises = SelectedNoises()
                
        ZenView()
            .environmentObject(noiseRepo)
            .environmentObject(selectedNoises)
    }
}
