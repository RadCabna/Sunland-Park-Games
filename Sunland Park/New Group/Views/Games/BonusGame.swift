//
//  BonusGame.swift
//  Sunland Park
//
//  Created by Алкександр Степанов on 03.06.2025.
//

import SwiftUI

struct BonusGame: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("bgNumber") var bgNumber = 1
    @AppStorage("coinCount") var coinCount: Int = 0
    @State private var offsetsArray: [CGFloat] = [1,-1,1,-1]
    @State private var bonusGameArray = Arrays.bonusQuestionArray
    @State private var answerData = UserDefaults.standard.array(forKey: "answerData") as? [Int] ?? [0,0,0]
    @State private var globalOpacity: CGFloat = 0
    @State private var questNumber = 1
    @State private var answerDone = false
    @State private var answerCorrect = false
    var body: some View {
        ZStack {
            Background(backgroundNumber: bgNumber)
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
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.horizontal)
            VStack(spacing: screenHeight*0.025) {
                Spacer()
                Buttons(size: 0.7, textSize: 0.4, text: "bonus \ngame")
                Text("\(questNumber)/3 question")
                    .font(Font.custom("Patsy Sans", size: screenHeight*0.04))
                    .foregroundColor(Color("textColor"))
                    .shadow(color:.black, radius: 3, x: 2, y: 3)
//                    .padding(.bottom, screenHeight*0.05)
                ZStack {
                    Image("bonusQuestionFrame")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight*0.18)
                    Text("\(bonusGameArray[questNumber-1].question)")
                        .font(Font.custom("Patsy Sans", size: screenHeight*0.03))
                        .foregroundColor(Color("textColor"))
                        .shadow(color:.black, radius: 3, x: 2, y: 3)
                        .padding(.horizontal, screenHeight*0.05)
                        .multilineTextAlignment(.center)
                }
                .offset(x: -screenWidth*offsetsArray[0])
                ForEach(0..<bonusGameArray.count, id: \.self) { item in
                    Buttons(size: 0.5, textSize: 0.3, text: bonusGameArray[questNumber-1].variant[item])
                        .offset(x: -screenWidth*offsetsArray[item])
                        .onTapGesture {
                            tapOnAnswer(item: item)
                        }
                }
                Spacer()
            }
            
            if answerDone && questNumber < 3 {
                BonusGameAnswerResult(correct: $answerCorrect, answerDone: $answerDone)
            }
            
            if answerDone && questNumber == 3 {
                BonusGameComplete(correct: $answerCorrect, answerDone: $answerDone)
            }
            
        }
        
        .onChange(of: answerDone) { _ in
        if !answerDone && questNumber < 3 {
                questNumber += 1
            buttonsAnimations()
            }
        }
        
        .onAppear {
            buttonsAnimations()
        }
        
    }
    
    func tapOnAnswer(item: Int) {
        if bonusGameArray[questNumber-1].variant[item] == bonusGameArray[questNumber-1].correctAnswer {
            answerCorrect = true
            answerData[questNumber-1] = 1
            UserDefaults.standard.setValue(answerData, forKey: "answerData")
        } else {
            answerCorrect = false
        }
        buttonsSlideOffAnimations()
        answerDone = true
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
    BonusGame()
}
