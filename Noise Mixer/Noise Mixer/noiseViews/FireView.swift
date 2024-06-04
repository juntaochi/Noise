//
//  FireView.swift
//  Noise Mixer
//
//  Created by Juntao Chi on 6/3/24.
//

import SwiftUI

struct FireView: View {
    var body: some View {
        VStack{
            Spacer()
            FireRectangle()
                .opacity(0.65)
                .frame(height: UIScreen.main.bounds.height * 2/5)
        }
    }
}

#Preview {
    FireView()
}
