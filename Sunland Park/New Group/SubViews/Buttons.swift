//
//  Buttons.swift
//  Sunland Park
//
//  Created by Алкександр Степанов on 03.06.2025.
//

import SwiftUI

struct Buttons: View {
    var size: CGFloat = 0.45
    var textSize: CGFloat = 0.45
    var text = "PLAY"
    var body: some View {
        Image("buttonFrame")
             .resizable()
             .scaledToFit()
             .frame(width: screenWidth*size)
             .overlay(
                 Text(text)
                     .font(Font.custom("Patsy Sans", size: screenHeight*textSize*0.1))
                     .foregroundColor(Color("textColor"))
                     .multilineTextAlignment(.center)
             )
             .shadow(color:.black, radius: 3, x: 2, y: 3)
             .mask(
                RoundedRectangle(cornerRadius: screenHeight*size*0.02)
             )
    }
}

#Preview {
    Buttons()
}
