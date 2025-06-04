//
//  SelectShopItem.swift
//  Sunland Park
//
//  Created by Алкександр Степанов on 03.06.2025.
//

import SwiftUI

struct SelectShopItem: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("coinCount") var coinCount: Int = 0
    @AppStorage("shopType") var shopType = 1
    @State private var offsetsArray: [CGFloat] = [1,-1]
    @State private var globalOpacity: CGFloat = 1
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
            VStack(spacing: screenHeight*0.025) {
                Buttons(size: 0.7,text: "SHOP")
                    .opacity(globalOpacity)
                    .padding(.top, screenHeight*0.07)
                Spacer()
                    .frame(height: screenHeight*0.13)
                Buttons(size: 0.7, textSize: 0.32, text: "INSTRUMENTS")
                    .offset(x: -screenWidth*offsetsArray[0])
                    .onTapGesture {
                        shopType = 1
                        buttonsSlideOffAnimations()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            coordinator.navigate(to: .shop)
                        }
                    }
                Buttons(size: 0.7, textSize: 0.32, text: "LOCATIONS")
                    .offset(x: -screenWidth*offsetsArray[1])
                    .onTapGesture {
                        shopType = 2
                        buttonsSlideOffAnimations()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            coordinator.navigate(to: .shop)
                        }
                    }
                Spacer()
            }
            .opacity(globalOpacity)
        }
        
        .onAppear {
//            showMenuAnimation()
            buttonsAnimations()
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
                    offsetsArray[i] = 1
                }
            }
            delay += 0.1
        }
    }
    
}

#Preview {
    SelectShopItem()
}
