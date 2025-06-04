//
//  MiniGame2.swift
//  Sunland Park
//
//  Created by Алкександр Степанов on 03.06.2025.
//

import SwiftUI

struct MiniGame2: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("coinCount") var coinCount: Int = 0
    @State private var globalOpacity: CGFloat = 0
    @State private var offsetsArray: [CGFloat] = [1,-1,1,-1,1]
    @State private var youWin = false
    @State private var youLose = false
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
    
}

#Preview {
    MiniGame2()
}
