//
//  BonusGameAnswerResult.swift
//  Sunland Park
//
//  Created by Алкександр Степанов on 08.06.2025.
//

import SwiftUI

struct BonusGameAnswerResult: View {
    @Binding var correct: Bool
    @Binding var answerDone: Bool
    var body: some View {
        ZStack {
            Color.black.opacity(0.5).ignoresSafeArea()
            VStack {
                Text(correct ? "CORRECT!" : "WRONG")
                    .font(Font.custom("Patsy Sans", size: screenHeight*0.07))
                    .foregroundColor(Color("textColor"))
                    .shadow(color: Color("textShadowColor"), radius: screenHeight*0.001)
                    .shadow(color: Color("textShadowColor"), radius: screenHeight*0.001)
                    .padding(.bottom, screenHeight*0.1)
                if correct {
                    Image("miniWinReward")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight*0.1)
                        .padding(.bottom, screenHeight*0.05)
                }
                Buttons(size: 0.5, textSize: 0.25, text: "next \nQuestion")
                    .onTapGesture {
                        answerDone.toggle()
                    }
            }
        }
    }
}

#Preview {
    BonusGameAnswerResult(correct: .constant(true), answerDone: .constant(true))
}
