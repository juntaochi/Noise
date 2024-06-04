//
//  RainView.swift
//  Noise Mixer
//
//  Created by Juntao Chi on 6/3/24.
//

import SwiftUI

struct RainView: View {
    var body: some View {
        VStack{
            RainRectangle()
                .frame(height: UIScreen.main.bounds.height * 3/4)
                .edgesIgnoringSafeArea(.top)
            Spacer()
        }
    }
}

#Preview {
    RainView()
}
