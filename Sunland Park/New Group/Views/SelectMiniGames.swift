//
//  SelectMiniGames.swift
//  Sunland Park
//
//  Created by Алкександр Степанов on 03.06.2025.
//

import SwiftUI

struct SelectMiniGames: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("coinCount") var coinCount: Int = 0
    @State private var offsetsArray: [CGFloat] = [1,-1,1,-1]
    @State private var globalOpacity: CGFloat = 0
    var body: some View {
        ZStack {
            Background(backgroundNumber: 1)
            HStack {
                Image("backButton")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.06)
                    .onTapGesture {
                        closeMenuAnimation()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            coordinator.navigateBack()
                        }
                    }
                Spacer()
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
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.horizontal)
            .opacity(globalOpacity)
            VStack(spacing: screenHeight*0.02) {
                Buttons(size: 0.7,textSize: 0.4, text: "FIND \nA COUPLE")
                    .offset(x: -screenWidth*offsetsArray[0])
                    .onTapGesture {
                        buttonsSlideOffAnimations()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            coordinator.navigate(to: .minGame1)
                        }
                    }
                Buttons(size: 0.7, textSize: 0.4, text: "GUESS \nTHE NUMBER")
                    .offset(x: -screenWidth*offsetsArray[1])
                    .onTapGesture {
                        buttonsSlideOffAnimations()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            coordinator.navigate(to: .minGame2)
                        }
                    }
                Buttons(size: 0.7, textSize: 0.4, text: "MATCH \nTHE CARD")
                    .offset(x: -screenWidth*offsetsArray[2])
                    .onTapGesture {
                        buttonsSlideOffAnimations()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            coordinator.navigate(to: .minGame3)
                        }
                    }
                Buttons(size: 0.7, textSize: 0.4, text: "MAZE")
                    .offset(x: -screenWidth*offsetsArray[3])
                    .onTapGesture {
                        buttonsSlideOffAnimations()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            coordinator.navigate(to: .minGame4)
                        }
                    }
                
            }
            .frame(maxHeight: screenHeight*0.8)
            .opacity(globalOpacity)
        }
        
        .onAppear {
           showMenuAnimation()
            buttonsAnimations()
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
    
    func buttonsSlideOffAnimations() {
        var delay: Double = 0
        for i in 0..<offsetsArray.count {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                withAnimation(Animation.easeInOut(duration: 0.7)) {
                    offsetsArray[i] = -1
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
    SelectMiniGames()
}
