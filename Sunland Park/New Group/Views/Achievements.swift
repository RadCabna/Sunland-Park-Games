//
//  Achievements.swift
//  Sunland Park
//
//  Created by Алкександр Степанов on 03.06.2025.
//

import SwiftUI

struct Achievements: View {
    @EnvironmentObject var coordinator: Coordinator
    @State private var globalOpacity: CGFloat = 0
    @AppStorage("coinCount") var coinCount: Int = 0
    @State private var offsetsArray: [CGFloat] = [1,-1,1,-1,1]
    @State private var achievementsArray = Arrays.achievementsTextArray
    @State private var achievementsData = UserDefaults.standard.array(forKey: "achievementsData") as? [Int] ?? [0,0,0,0,0]
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
            VStack(spacing: screenHeight*0.035) {
                Buttons(size: 0.7,textSize: 0.36, text: "ACHIEVEMENTS")
                    .opacity(globalOpacity)
                    .padding(.top, screenHeight*0.07)
                Spacer()
                ForEach(0..<achievementsArray.count, id: \.self) { item in
                    ZStack {
                        Image("achievementsFrame")
                            .resizable()
                            .scaledToFit()
                            .frame(height: screenHeight*0.082)
                        Text(achievementsArray[item])
                            .font(Font.custom("Patsy Sans", size: screenHeight*0.02))
                            .foregroundColor(Color("textColor"))
                            .shadow(color:.black, radius: 3, x: 2, y: 3)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, screenHeight*0.09)
                        if achievementsData[item] == 1 {
                            Image("achievementsReward")
                                .resizable()
                                .scaledToFit()
                                .frame(height: screenHeight*0.05)
                                .offset(y: screenHeight*0.05)
                                .onTapGesture {
                                    coinCount += 10
                                    achievementsData[item] = 2
                                }
                        }
                        if achievementsData[item] == 2 {
                            Image("achievementsDone")
                                .resizable()
                                .scaledToFit()
                                .frame(height: screenHeight*0.05)
                                .offset(y: screenHeight*0.05)
                            
                        }
                    }
                    .offset(x: screenWidth*offsetsArray[item])
                }
                Spacer()
            }
            .opacity(globalOpacity)
        }
        
        .onAppear {
            showMenuAnimation()
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
    
}

#Preview {
    Achievements()
}
