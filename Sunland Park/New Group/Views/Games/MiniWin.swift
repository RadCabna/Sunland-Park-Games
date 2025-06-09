//
//  MiniWin.swift
//  Sunland Park
//
//  Created by Алкександр Степанов on 04.06.2025.
//

import SwiftUI

struct MiniWin: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("sound") var sound = true
    @AppStorage("coinCount") var coinCount: Int = 0
    @Binding var youWin: Bool
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
            VStack {
                Text("YOU WIN!")
                    .font(Font.custom("Patsy Sans", size: screenHeight*0.07))
                    .foregroundColor(Color("textColor"))
                    .shadow(color: Color("textShadowColor"), radius: screenHeight*0.001)
                    .shadow(color: Color("textShadowColor"), radius: screenHeight*0.001)
                    .padding(.bottom, screenHeight*0.1)
                Image("miniWinReward")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.1)
                    .padding(.bottom, screenHeight*0.05)
                Buttons(textSize: 0.35 ,text: "RESTART")
                    .onTapGesture {
                        coinCount += 10
                        youWin.toggle()
                    }
                Buttons(textSize: 0.35 ,text: "MENU")
                    .onTapGesture {
                        coinCount += 10
                        coordinator.navigate(to: .mainMenu)
                    }
            }
            .padding(.bottom, screenHeight*0.1)
        }
        
        .onAppear {
            if sound {
                SoundManager.instance.playSound(sound: "winSound")
            }
        }
        
    }
}

#Preview {
    MiniWin(youWin: .constant(true))
}
