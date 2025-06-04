//
//  Menu.swift
//  Sunland Park
//
//  Created by Алкександр Степанов on 03.06.2025.
//

import SwiftUI

struct Menu: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("coinCount") var coinCount: Int = 0
    @State private var offsetsArray: [CGFloat] = [1,1,1,1,1]
    @State private var globalOpacity: CGFloat = 0
    var body: some View {
        ZStack {
            Background(backgroundNumber: 1)
                Image("countFrame")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.06)
                    .overlay(
                        Text("\(coinCount)")
                            .font(Font.custom("Patsy Sans", size: screenHeight*0.03))
                            .foregroundColor(Color("textColor"))
                            .offset(x: screenHeight*0.025)
                    )
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .padding(.horizontal)
                    .opacity(globalOpacity)
            VStack(spacing: screenHeight*0.02) {
                Image("loadingLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.25)
                Buttons(size: 0.6, textSize: 0.6, text: "PLAY")
                    .offset(x: -screenWidth*offsetsArray[0])
                Buttons(size: 0.45, textSize: 0.45, text: "SHOP")
                    .offset(x: -screenWidth*offsetsArray[1])
                    .onTapGesture {
                        closeMenuAnimation()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            coordinator.navigate(to: .selectShopItem)
                        }
                    }
                Buttons(size: 0.45, textSize: 0.33, text: "SETTINGS")
                    .offset(x: -screenWidth*offsetsArray[2])
                    .onTapGesture {
                        closeMenuAnimation()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            coordinator.navigate(to: .settings)
                        }
                    }
                Buttons(size: 0.45, textSize: 0.23, text: "ACHIEVEMENTS")
                    .offset(x: -screenWidth*offsetsArray[3])
                    .onTapGesture {
                        closeMenuAnimation()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            coordinator.navigate(to: .achievements)
                        }
                    }
                Buttons(size: 0.45, textSize: 0.26, text: "MINI GAMES")
                    .offset(x: -screenWidth*offsetsArray[4])
                    .onTapGesture {
                        closeMenuAnimation()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            coordinator.navigate(to: .selectMiniGames)
                        }
                    }
            }
            .opacity(globalOpacity)
        }
        
        .onAppear {
            buttonsAnimations()
            showMenuAnimation()
        }
        
    }
    
    func buttonsAnimations() {
        var delay: Double = 0
        for i in 0..<offsetsArray.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                withAnimation(Animation.easeInOut(duration: 0.7)) {
                    offsetsArray[i] = 0
                }
            }
            delay += 0.1
        }
    }
    
    func showMenuAnimation() {
        withAnimation(Animation.easeInOut(duration: 0.2)) {
            globalOpacity = 1
        }
    }
    
    func closeMenuAnimation() {
        withAnimation(Animation.easeInOut(duration: 0.2)) {
            globalOpacity = 0
        }
    }

    
}

#Preview {
    Menu()
}
