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
    @State private var offsetsArray: [CGFloat] = [1,-1,1,-1]
    @State private var youLose = false
    @State private var youWin = false
    @State private var correctNumber = [4, 5, 6]
    @State private var yourNumber = [10, 10, 10]
    @State private var numberId = 0
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
            VStack(spacing: screenHeight*0.02) {
                HStack {
                    ForEach(0..<yourNumber.count, id: \.self) { item in
                        ZStack {
                            Image("yourCardFrame")
                                .resizable()
                                .scaledToFit()
                                .frame(height: screenHeight*0.09)
                            if yourNumber[item] != 10 {
                                Text("\(yourNumber[item])")
                                    .font(Font.custom("Patsy Sans", size: screenHeight*0.04))
                                    .foregroundColor(yourNumber[item] == correctNumber[item] ? Color("textColor") : .red)
                            }
                        }
                    }
                }
                .offset(x: -screenWidth*offsetsArray[0])
                HStack {
                    ForEach(0..<3, id:\.self) { item in
                        ZStack {
                            Image("closeCard")
                                .resizable()
                                .scaledToFit()
                                .frame(height: screenHeight*0.1)
                            Text("\(item+1)")
                                .font(Font.custom("Patsy Sans", size: screenHeight*0.04))
                                .foregroundColor(Color("textColor"))
                        }
                        .onTapGesture {
                            tapOnNumber(item: item)
                        }
                    }
                }
                .offset(x: -screenWidth*offsetsArray[1])
                HStack {
                    ForEach(3..<6, id:\.self) { item in
                        ZStack {
                            Image("closeCard")
                                .resizable()
                                .scaledToFit()
                                .frame(height: screenHeight*0.1)
                            Text("\(item+1)")
                                .font(Font.custom("Patsy Sans", size: screenHeight*0.04))
                                .foregroundColor(Color("textColor"))
                        }
                        .onTapGesture {
                            tapOnNumber(item: item)
                        }
                    }
                }
                .offset(x: -screenWidth*offsetsArray[2])
                HStack {
                    ForEach(6..<9, id:\.self) { item in
                        ZStack {
                            Image("closeCard")
                                .resizable()
                                .scaledToFit()
                                .frame(height: screenHeight*0.1)
                            Text("\(item+1)")
                                .font(Font.custom("Patsy Sans", size: screenHeight*0.04))
                                .foregroundColor(Color("textColor"))
                        }
                        .onTapGesture {
                            tapOnNumber(item: item)
                        }
                    }
                }
                .offset(x: -screenWidth*offsetsArray[3])
            }
            
            if youLose {
                MiniLose(youLose: $youLose)
            }
            if youWin {
                MiniWin(youWin: $youWin)
            }
            
        }
        
        .onChange(of: youWin) { _ in
            if !youWin {
                loseRestart()
                shuffleNumber()
                buttonsAnimations()
            }
        }
        
        .onChange(of: youLose) { _ in
            if !youLose {
                loseRestart()
            }
        }
        
        .onChange(of: numberId) { _ in
            if numberId == 3 {
               checCorrect()
            }
        }
        
        .onAppear {
            shuffleNumber()
            buttonsAnimations()
        }
        
    }
    
    func loseRestart() {
        yourNumber = [10, 10, 10]
        numberId = 0
    }
    
    func shuffleNumber() {
        for i in 0..<correctNumber.count {
            correctNumber[i] = .random(in: 1...9)
        }
    }
    
    func checCorrect() {
        if yourNumber == correctNumber {
            youWin = true
            buttonsSlideOffAnimations()
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                youLose = true
            }
        }
    }
    
    func tapOnNumber(item: Int) {
        if numberId < 3 {
            yourNumber[numberId] = item+1
            numberId += 1
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
