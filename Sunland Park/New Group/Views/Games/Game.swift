//
//  Game.swift
//  Sunland Park
//
//  Created by Алкександр Степанов on 03.06.2025.
//

import SwiftUI

struct Game: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("coinCount") var coinCount: Int = 0
    @AppStorage("bgNumber") var bgNumber = 1
    @AppStorage("instrumentNumber") var instrumentNumber = 1
    @State private var gameInProgress = true
    @State private var globalOpacity: CGFloat = 0
    @State private var instrumentName = "instrument1"
    @State private var instrumentXOffset: CGFloat = 0
    @State private var instrumentYOffset: CGFloat = 0
    @State private var instrumentRotation: CGFloat = 0
    @State private var gameItemsArray = Arrays.gameItemsArray
    @State private var allNotesArrays = Arrays.allNotesArray
    @State private var notesTimer: Timer? = nil
    @State private var bonusTimer: Timer? = nil
    @State private var changeColorTimer: Timer? = nil
    @State private var checkTimer: Timer? = nil
    @State private var gameColorCircle: GameColorCirsle = GameColorCirsle(colorType: 1, name: "blueCircle")
    @State private var gameColorCircleArray = Arrays.colorCircleArray
    @State private var circleScale: CGFloat = 1
    @State private var circleOpacity: CGFloat = 1
    @State private var dropBonus = Arrays.dropBonus
    var body: some View {
        ZStack {
            Background(backgroundNumber: bgNumber)
            ForEach(0..<gameItemsArray.count, id: \.self) { index in
                Image(gameItemsArray[index].name)
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth*0.08)
                    .opacity(gameItemsArray[index].opacity)
                    .offset(x: gameItemsArray[index].xOffset*screenWidth, y:gameItemsArray[index].yOffset*screenHeight)
                
            }
            Image(dropBonus.name)
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth*0.1)
                .opacity(dropBonus.opacity)
                .offset(x: dropBonus.xOffset*screenWidth, y:dropBonus.yOffset*screenHeight)
            HStack {
                Image("backButton")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.06)
                    .onTapGesture {
                        closeMenuAnimation()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            gameInProgress = false
                            stopCheckTimer()
                            stopChangeColorTimer()
                            stopNotesTimer()
                            coordinator.navigate(to: .mainMenu)
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
                Spacer()
                ZStack {
                    Image(gameColorCircle.name)
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight*0.05)
                        .scaleEffect(x: circleScale, y: circleScale)
                        .opacity(circleOpacity)
                    Image(gameColorCircle.name)
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight*0.05)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.horizontal)
            HStack {
                Image("arrowLeft")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.08)
                    .onTapGesture {
                     moveInstrumentLeft()
                    }
               Spacer()
                Image("arrowLeft")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.08)
                    .scaleEffect(x: -1)
                    .onTapGesture {
                        moveInstrumentRight()
                    }
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.horizontal)
            Image(instrumentName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: screenHeight*0.12 , maxHeight: screenHeight*0.17)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(.bottom, screenHeight*0.1)
                .offset(y: instrumentYOffset*screenHeight)
                .rotationEffect(Angle(degrees: instrumentRotation))
                .offset(y: -instrumentYOffset*screenHeight)
                .offset(x: screenWidth*instrumentXOffset, y: instrumentYOffset*screenHeight)
        }
        
        .onAppear {
            updateInstrument()
            startNotesTimer()
            startBonusTimer()
            startChangeColorTimer()
            startCheckTimer()
        }
        
    }
    
    
    func dropBonusAnimation() {
        let xOffsetsArray = [-0.3, -0.15, 0, 0.15, 0.3]
        dropBonus.timer?.invalidate()
        dropBonus.timer = nil
        dropBonus.yOffset = CGFloat.random(in: -0.8 ... -0.7)
        dropBonus.xOffset = xOffsetsArray.randomElement()!
        dropBonus.dropTime = CGFloat.random(in: 0.01...0.02)
        dropBonus.timer = Timer.scheduledTimer(withTimeInterval: dropBonus.dropTime, repeats: true) { _ in
            withAnimation() {
                dropBonus.yOffset += 0.01
            }
        }
    }
    
    func startBonusTimer() {
        if bonusTimer == nil {
            bonusTimer = Timer.scheduledTimer(withTimeInterval: 7, repeats: true) { _ in
                dropBonusAnimation()
            }
        }
    }
    
    func stopBonusTimer() {
        bonusTimer?.invalidate()
        bonusTimer = nil
    }
    
    func createDropItemsArray() {
        let xOffsetsArray = [-0.3, -0.15, 0, 0.15, 0.3]
        for i in 0..<gameItemsArray.count {
            let randomeRow = Int.random(in: 0..<5)
            let randomeCol = Int.random(in: 0..<6)
            gameItemsArray[i].name = allNotesArrays[randomeRow][randomeCol].name
            gameItemsArray[i].colorType = allNotesArrays[randomeRow][randomeCol].colorType
            DispatchQueue.main.asyncAfter(deadline: .now() + gameItemsArray[i].delay) {
                gameItemsArray[i].timer?.invalidate()
                gameItemsArray[i].timer = nil
                gameItemsArray[i].yOffset = CGFloat.random(in: -0.8 ... -0.7)
                gameItemsArray[i].xOffset = xOffsetsArray.randomElement()!
                gameItemsArray[i].dropTime = CGFloat.random(in: 0.02...0.04)
                gameItemsArray[i].timer = Timer.scheduledTimer(withTimeInterval: gameItemsArray[i].dropTime, repeats: true) { _ in
                    withAnimation() {
                        gameItemsArray[i].yOffset += 0.01
                    }
                }
            }
        }
    }
    
    func startCheckTimer() {
        checkTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            for i in 0..<gameItemsArray.count {
                if gameItemsArray[i].yOffset > 0.25 &&
                    gameItemsArray[i].yOffset < 0.55 &&
                    gameItemsArray[i].xOffset == instrumentXOffset &&
                    !gameItemsArray[i].collected  {
                    if gameItemsArray[i].colorType == gameColorCircle.colorType {
                        coinCount += 1
                    } else {
                        coinCount -= 1
                    }
                    gameItemsArray[i].opacity = 0
                    gameItemsArray[i].collected = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        gameItemsArray[i].collected = false
                        gameItemsArray[i].opacity = 1
                    }
                }
            }
            if dropBonus.yOffset > 0.25 &&
                dropBonus.yOffset < 0.55 &&
                dropBonus.xOffset == instrumentXOffset &&
                !dropBonus.collected {
                stopCheckTimer()
                stopChangeColorTimer()
                stopNotesTimer()
                closeMenuAnimation()
//                SoundManager.instance.loopSound(sound: "soundCoin")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    if gameInProgress {
                        coordinator.navigate(to: .bonusGame)
                    }
                }
                dropBonus.opacity = 0
                dropBonus.collected = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    dropBonus.collected = false
                    dropBonus.opacity = 1
                }
            }
        }
    }
    
    func stopCheckTimer() {
        checkTimer?.invalidate()
        checkTimer = nil
    }
    
    func startNotesTimer() {
        if notesTimer == nil {
            createDropItemsArray()
            notesTimer = Timer.scheduledTimer(withTimeInterval: 7, repeats: true) { _ in
                createDropItemsArray()
            }
        }
    }
    
    func stopNotesTimer() {
        notesTimer?.invalidate()
        notesTimer = nil
    }
    
    func startChangeColorTimer() {
        if changeColorTimer == nil {
            changeColorTimer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { _ in
                gameColorCircle = gameColorCircleArray.randomElement() ?? GameColorCirsle(colorType: 1, name: "blueCircle")
                withAnimation(Animation.easeOut(duration: 0.5)) {
                    circleScale = 2
                    circleOpacity = 0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(Animation.easeIn(duration: 0.5)) {
                        circleScale = 1
                        circleOpacity = 1
                    }
                }
            }
        }
    }
    
    func stopChangeColorTimer() {
        changeColorTimer?.invalidate()
        changeColorTimer = nil
    }
    
    func moveInstrumentLeft() {
        if instrumentXOffset > -0.3 {
            withAnimation(Animation.easeInOut(duration: 0.5)) {
                instrumentXOffset -= 0.15
                instrumentXOffset = (instrumentXOffset * 100).rounded() / 100
            }
            withAnimation(Animation.easeInOut(duration: 0.2)) {
                instrumentYOffset += 0.005
                instrumentRotation += 7
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(Animation.easeInOut(duration: 0.2)) {
                    instrumentYOffset -= 0.005
                    instrumentRotation -= 7
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                print(instrumentXOffset)
            }
        }
    }
    
    func moveInstrumentRight() {
        if instrumentXOffset < 0.3 {
            withAnimation(Animation.easeInOut(duration: 0.5)) {
                instrumentXOffset += 0.15
                instrumentXOffset = (instrumentXOffset * 100).rounded() / 100
            }
            withAnimation(Animation.easeInOut(duration: 0.2)) {
                instrumentYOffset += 0.005
                instrumentRotation -= 7
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(Animation.easeInOut(duration: 0.2)) {
                    instrumentYOffset -= 0.005
                    instrumentRotation += 7
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                print(instrumentXOffset)
            }
        }
    }
    
    func updateInstrument() {
        switch instrumentNumber {
        case 2:
            instrumentName = "instrument2"
        case 3:
            instrumentName = "instrument3"
        case 4:
            instrumentName = "instrument4"
        default:
            instrumentName = "instrument1"
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
    Game()
}
