//
//  BonusGameComplete.swift
//  Sunland Park
//
//  Created by Алкександр Степанов on 08.06.2025.
//

import SwiftUI

struct BonusGameComplete: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("sound") var sound = true
    @State private var answerData = UserDefaults.standard.array(forKey: "answerData") as? [Int] ?? [0,0,0]
    @Binding var correct: Bool
    @Binding var answerDone: Bool
    @State private var reward = 0
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
            VStack {
                Text("Bonus Game \nComplete!")
                    .font(Font.custom("Patsy Sans", size: screenHeight*0.06))
                    .foregroundColor(Color("textColor"))
                    .multilineTextAlignment(.center)
                    .shadow(color: Color("textShadowColor"), radius: screenHeight*0.001)
                    .shadow(color: Color("textShadowColor"), radius: screenHeight*0.001)
                    .padding(.bottom, screenHeight*0.1)
                    Image("countFrame")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight*0.1)
                        .overlay(
                            Text("+\(reward)")
                                .font(Font.custom("Patsy Sans", size: screenHeight*0.04))
                                .foregroundColor(Color("textColor"))
                                .offset(x: screenHeight*0.035)
                        )
                    .padding(.bottom)
                Buttons(size: 0.5, textSize: 0.35, text: "continue")
                    .onTapGesture {
                        resetAnswerData()
                        coordinator.navigate(to: .game)
                    }
                Buttons(size: 0.5, textSize: 0.4, text: "menu")
                    .onTapGesture {
                        resetAnswerData()
                        coordinator.navigate(to: .mainMenu)
                    }
            }
        }
        
        .onAppear {
            whatReward()
            if sound {
                SoundManager.instance.playSound(sound: "winSound")
            }
        }
        
    }
    
    func resetAnswerData() {
        answerData = [0,0,0]
        UserDefaults.standard.setValue(answerData, forKey: "answerData")
    }
    
    func whatReward() {
        for i in 0..<answerData.count {
            if answerData[i] == 1 {
                reward += 10
            }
        }
    }
    
}

#Preview {
    BonusGameComplete(correct: .constant(true), answerDone: .constant(true))
}
