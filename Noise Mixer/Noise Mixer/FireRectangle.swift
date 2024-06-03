//
//  GradientRectangle.swift
//  Noise Mixer
//John Lucaccioni: joluca@iu.edu
//Juntao Chi: chijun@iu.edu
//Submit date: April 28


import SwiftUI
import UIKit

struct FireRectangle: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        return GradientDrawingView(frame: .zero)
    }

    func updateUIView(_ uiView: UIView, context: Context) {
    }
    
    private class GradientDrawingView: UIView {
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .clear
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func draw(_ rect: CGRect) {
            super.draw(rect)
            guard let context = UIGraphicsGetCurrentContext() else { return }
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let colors = [UIColor.clear.cgColor,UIColor.red.withAlphaComponent(0.2).cgColor] as CFArray
            guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: [0.0, 1.0]) else { return }
            let startPoint = CGPoint(x: rect.midX, y: rect.minY)
            let endPoint = CGPoint(x: rect.midX, y: rect.maxY)
            context.drawLinearGradient(gradient, start: startPoint, end: endPoint, options: [])
        }
    }
}
