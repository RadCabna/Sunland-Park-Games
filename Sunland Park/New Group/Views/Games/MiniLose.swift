//
//  MiniLose.swift
//  Sunland Park
//
//  Created by Алкександр Степанов on 04.06.2025.
//

import SwiftUI

struct MiniLose: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("sound") var sound = true
    @Binding var youLose: Bool
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
            VStack {
                Text("YOU LOSE")
                    .font(Font.custom("Patsy Sans", size: screenHeight*0.07))
                    .foregroundColor(Color("textColor"))
                    .shadow(color: Color("textShadowColor"), radius: screenHeight*0.001)
                    .shadow(color: Color("textShadowColor"), radius: screenHeight*0.001)
                    .padding(.bottom, screenHeight*0.1)
                Buttons(textSize: 0.35 ,text: "RESTART")
                    .onTapGesture {
                        youLose.toggle()
                    }
                Buttons(textSize: 0.35 ,text: "MENU")
                    .onTapGesture {
                        coordinator.navigate(to: .mainMenu)
                    }
            }
            .padding(.bottom, screenHeight*0.1)
        }
        .onAppear {
            if sound {
                SoundManager.instance.playSound(sound: "loseSound")
            }
        }
    }
}

#Preview {
    MiniLose(youLose: .constant(true))
}
