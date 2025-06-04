//
//  MiniGame1.swift
//  Sunland Park
//
//  Created by Алкександр Степанов on 03.06.2025.
//

import SwiftUI

struct MiniGame1: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("coinCount") var coinCount: Int = 0
    @State private var offsetsArray: [CGFloat] = [1,-1,1,-1,1]
    @State private var yourLife = [0,0,0,0]
    @State private var mistakeCount = 0
    @State private var globalOpacity: CGFloat = 0
    @State private var cardLogoArray = Arrays.cardsArray
    @State private var closeCardsArray: [Cards] = Array(repeating: Cards(name: ""), count: 12)
    @State private var chosenCards: [String] = []
    @State private var chosenCardsIndexArray: [Int] = []
    @State private var pairsCount = 0
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
            VStack(spacing: screenHeight*0.02) {
                HStack {
                    ForEach(0..<yourLife.count, id: \.self) { item in
                        ZStack {
                            Image("yourCardFrame")
                                .resizable()
                                .scaledToFit()
                                .frame(height: screenHeight*0.09)
                            if yourLife[item] == 1 {
                                Image("redCross")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenHeight*0.06)
                                    .shadow(color: .black, radius: 2)
                            }
                        }
                    }
                }
                .offset(x: -screenWidth*offsetsArray[0])
                HStack(spacing: screenHeight*0.02) {
                    ForEach(0..<3, id: \.self) { item in
                        ZStack {
                            Image("closeCard")
                                .resizable()
                                .scaledToFit()
                                .frame(height: screenHeight*0.1)
                            if closeCardsArray[item].open {
                                Image(closeCardsArray[item].name)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenHeight*0.05)
                            }
                        }
                        .onTapGesture {
                            tapOnCard(item: item)
                        }
                    }
                }
                .offset(x: -screenWidth*offsetsArray[1])
                HStack(spacing: screenHeight*0.02) {
                    ForEach(3..<6, id: \.self) { item in
                        ZStack {
                            Image("closeCard")
                                .resizable()
                                .scaledToFit()
                                .frame(height: screenHeight*0.1)
                            if closeCardsArray[item].open {
                                Image(closeCardsArray[item].name)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenHeight*0.05)
                            }
                        }
                        .onTapGesture {
                            tapOnCard(item: item)
                        }
                    }
                }
                .offset(x: -screenWidth*offsetsArray[2])
                HStack(spacing: screenHeight*0.02) {
                    ForEach(6..<9, id: \.self) { item in
                        ZStack {
                            Image("closeCard")
                                .resizable()
                                .scaledToFit()
                                .frame(height: screenHeight*0.1)
                            if closeCardsArray[item].open {
                                Image(closeCardsArray[item].name)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenHeight*0.05)
                            }
                        }
                        .onTapGesture {
                            tapOnCard(item: item)
                        }
                    }
                }
                .offset(x: -screenWidth*offsetsArray[3])
                HStack(spacing: screenHeight*0.02) {
                    ForEach(9..<12, id: \.self) { item in
                        ZStack {
                            Image("closeCard")
                                .resizable()
                                .scaledToFit()
                                .frame(height: screenHeight*0.1)
                            if closeCardsArray[item].open {
                                Image(closeCardsArray[item].name)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenHeight*0.05)
                            }
                        }
                        .onTapGesture {
                            tapOnCard(item: item)
                        }
                    }
                }
                .offset(x: -screenWidth*offsetsArray[4])
            }
            
            if youLose {
                MiniLose(youLose: $youLose)
            }
            if youWin {
                MiniWin(youWin: $youWin)
            }
        }
        
        .onChange(of: pairsCount) { _ in
            if pairsCount == 6 {
                youWin = true
                buttonsSlideOffAnimations()
            }
        }
        
        .onChange( of: mistakeCount) { _ in
            if mistakeCount >= 4 {
                youLose = true
                buttonsSlideOffAnimations()
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
        
        .onAppear {
            shuffleCards()
            showMenuAnimation()
            buttonsAnimations()
        }
        
    }
    
    func restartGame() {
        cardLogoArray = Arrays.cardsArray
        shuffleCards()
        chosenCards = []
        chosenCardsIndexArray = []
        mistakeCount = 0
        yourLife = [0,0,0,0]
        buttonsAnimations()
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
    
    func shuffleCards() {
        closeCardsArray = cardLogoArray.shuffled() + cardLogoArray.shuffled()
        closeCardsArray = closeCardsArray.shuffled()
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
    
    func tapOnCard(item: Int) {
        if !closeCardsArray[item].open {
            withAnimation() {
                closeCardsArray[item].open = true
            }
            chosenCards.append(closeCardsArray[item].name)
            chosenCardsIndexArray.append(item)
        }
        if chosenCardsIndexArray.count == 2 {
            checkYourCards()
        }
    }
    
    func checkYourCards() {
        if chosenCards[0] != chosenCards[1] {
            yourLife[mistakeCount] = 1
            mistakeCount += 1
            for i in 0..<closeCardsArray.count {
                if closeCardsArray[i].open && !closeCardsArray[i].correct {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation() {
                            closeCardsArray[i].open = false
                        }
                    }
                }
            }
        } else {
            closeCardsArray[chosenCardsIndexArray[0]].correct = true
            closeCardsArray[chosenCardsIndexArray[1]].correct = true
            pairsCount += 1
        }
        chosenCards.removeAll()
        chosenCardsIndexArray.removeAll()
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
    MiniGame1()
}
