//
//  MiniGame3.swift
//  Sunland Park
//
//  Created by Алкександр Степанов on 03.06.2025.
//

import SwiftUI

struct MiniGame3: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("coinCount") var coinCount: Int = 0
    @State private var globalOpacity: CGFloat = 0
    @State private var yourCardsArray: [String] = ["yourCardFrame","yourCardFrame","yourCardFrame","yourCardFrame"]
    @State private var cardLogoArray = Arrays.cardLogoArray
    @State private var gameCorrectCardArray: [String] = ["figure1", "figure2", "figure3", "figure4"]
    @State private var cardsOnGameField = ["figure1", "figure2", "figure3", "figure4"]
    @State private var stepNumber = 0
    @State private var showCardNumber = 0
    @State private var gameFieldOpacity: CGFloat = 1
    @State private var startButtonOpacity: CGFloat = 0
    @State private var showCardOpacity:CGFloat = 0
    @State private var offsetsArray: [CGFloat] = [1,-1,1]
    @State private var youLose = false
    @State private var youWin = false
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
            VStack(spacing: screenHeight*0.03) {
                HStack {
                    ForEach(0..<yourCardsArray.count, id: \.self) { item in
                        ZStack {
                            Image("yourCardFrame")
                                .resizable()
                                .scaledToFit()
                                .frame(height: screenHeight*0.09)
                            if yourCardsArray[item] != "yourCardFrame" {
                                Image(yourCardsArray[item])
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenHeight*0.05)
                            }
                        }
                    }
                }
                .offset(x: -screenWidth*offsetsArray[0])
                HStack(spacing: screenHeight*0.03) {
                    ForEach(0..<2, id: \.self) { item in
                        ZStack {
                            Image("closeCard")
                                .resizable()
                                .scaledToFit()
                                .frame(height: screenHeight*0.14)
                            Image(cardsOnGameField[item])
                                .resizable()
                                .scaledToFit()
                                .frame(height: screenHeight*0.07)
                        }
                        .onTapGesture {
                            tapOnCard(item: item)
                        }
                    }
                }
                .offset(x: -screenWidth*offsetsArray[1])
                HStack(spacing: screenHeight*0.03) {
                    ForEach(2..<4, id: \.self) { item in
                        ZStack {
                            Image("closeCard")
                                .resizable()
                                .scaledToFit()
                                .frame(height: screenHeight*0.14)
                            Image(cardsOnGameField[item])
                                .resizable()
                                .scaledToFit()
                                .frame(height: screenHeight*0.07)
                        }
                        .onTapGesture {
                            tapOnCard(item: item)
                        }
                    }
                }
                .offset(x: -screenWidth*offsetsArray[2])
            }
            .opacity(gameFieldOpacity)
           Image("startMiniGameButton")
                .resizable()
                .scaledToFit()
                .frame(height: screenHeight*0.2)
                .opacity(startButtonOpacity)
                .onTapGesture {
                    startGame()
                }
            ZStack {
                Image("closeCard")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.16)
                Image(gameCorrectCardArray[showCardNumber])
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.08)
            }
            .opacity(showCardOpacity)
            
            if youLose {
                MiniLose(youLose: $youLose)
            }
            if youWin {
                MiniWin(youWin: $youWin)
            }
            
        }
        
        .onChange(of: youLose) { _ in
            if !youLose {
                restartGame()
            }
        }
        
        .onChange(of: youWin) { _ in
            if !youWin {
                restartGame()
            }
        }
        
        .onChange(of: stepNumber) { _ in
            if stepNumber == 4 {
                checkCorrect()
            }
        }
        
        .onAppear {
            createCorrectCardsArray()
            withAnimation(Animation.easeInOut(duration: 0.5)) {
                startButtonOpacity = 1
            }
        }
        
    }
    
    func checkCorrect() {
        if yourCardsArray == gameCorrectCardArray {
            youWin = true
        } else {
            youLose = true
        }
    }
    
    func startGame() {
        var delay: Double = 0
        
        withAnimation(Animation.easeInOut(duration: 0.5)) {
            startButtonOpacity = 0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(Animation.easeInOut(duration: 0.5)) {
                showCardOpacity = 1
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            for _ in 0..<gameCorrectCardArray.count {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay + 0.5) {
                    if showCardNumber < gameCorrectCardArray.count - 1 {
                        showCardNumber += 1
                    }
                }
                delay += 0.5
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation(Animation.easeInOut(duration: 0.5)) {
                showCardOpacity = 0
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            shuffleCardsPosition()
           buttonsAnimations()
        }
    }
    
    func restartGame() {
        stepNumber = 0
        showCardNumber = 0
        buttonsSlideOffAnimations()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(Animation.easeInOut(duration: 0.5)) {
                startButtonOpacity = 1
            }
        }
        yourCardsArray = ["yourCardFrame","yourCardFrame","yourCardFrame","yourCardFrame"]
        createCorrectCardsArray()
    }
    
    func tapOnCard(item: Int) {
        if stepNumber < 4 {
            yourCardsArray[stepNumber] = cardsOnGameField[item]
            stepNumber += 1
        }
    }
    
    func createCorrectCardsArray() {
        gameCorrectCardArray = Array(cardLogoArray.shuffled().prefix(4))
    }
    
    func shuffleCardsPosition() {
        cardsOnGameField = gameCorrectCardArray
        cardsOnGameField = cardsOnGameField.shuffled()
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
    MiniGame3()
}
