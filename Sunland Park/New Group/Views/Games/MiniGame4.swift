//
//  MiniGame4.swift
//  Sunland Park
//
//  Created by Алкександр Степанов on 03.06.2025.
//

import SwiftUI

struct MiniGame4: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("coinCount") var coinCount: Int = 0
    @State private var globalOpacity: CGFloat = 0
    @State private var labyrinthArray = Arrays.labyrinthArray
    @State private var posibleStepsArray = Arrays.posibleStepsArray
    @State private var slide1Opacity: CGFloat = 0
    @State private var slide2Opacity: CGFloat = 0
    @State private var slide3Opacity: CGFloat = 0
    @State private var slide4Opacity: CGFloat = 0
    @State private var offsetsArray: [CGFloat] = [1,-1]
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
            VStack(spacing: screenHeight*0.08) {
                ZStack {
                    Image("labirinthFrame")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight*0.4)
                    Image("labirinth")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight*0.35)
                    VStack(spacing: screenHeight*0.007) {
                        ForEach(0..<labyrinthArray.count, id: \.self) { row in
                            HStack(spacing: screenHeight*0.006) {
                                ForEach(0..<labyrinthArray[row].count, id: \.self) { col in
                                    ZStack {
                                        Image("shopInsrument1")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: screenHeight*0.02)
                                            .scaleEffect(x: 3, y: 3)
                                            .opacity(labyrinthArray[row][col].guitar ? 1 : 0)
                                        Image("cube")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: screenHeight*0.021)
                                            .opacity(labyrinthArray[row][col].cube ? 1 : 0)
                                        Image("slideLine")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: screenHeight*0.022)
                                            .opacity(labyrinthArray[row][col].cube ? slide1Opacity : 0)
                                            .offset(y: -screenHeight*0.022)
                                        Image("slideLine")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: screenHeight*0.022)
                                            .opacity(labyrinthArray[row][col].cube ? slide2Opacity : 0)
                                            .scaleEffect(y: -1)
                                            .offset(y: screenHeight*0.02)
                                        Image("slideLine")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: screenHeight*0.022)
                                            .opacity(labyrinthArray[row][col].cube ? slide3Opacity : 0)
                                            .rotationEffect(Angle(degrees: 90))
                                            .scaleEffect(y: -1)
                                            .offset(x: screenHeight*0.021)
                                        Image("slideLine")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: screenHeight*0.022)
                                            .opacity(labyrinthArray[row][col].cube ? slide4Opacity : 0)
                                            .rotationEffect(Angle(degrees: -90))
                                            .scaleEffect(y: -1)
                                            .offset(x: -screenHeight*0.021)
                                    }
                                }
                            }
                        }
                    }
                }
                .offset(x: -screenWidth*offsetsArray[0])
                VStack(spacing: screenHeight*0.04) {
                    Image("arrowUp")
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight*0.09)
                        .onTapGesture {
                            stepUp()
                        }
                    HStack(spacing: screenHeight*0.04) {
                        Image("arrowLeft")
                            .resizable()
                            .scaledToFit()
                            .frame(height: screenHeight*0.09)
                            .onTapGesture {
                                stepLeft()
                            }
                        Image("arrowUp")
                            .resizable()
                            .scaledToFit()
                            .frame(height: screenHeight*0.09)
                            .scaleEffect(y: -1)
                            .onTapGesture {
                                stepDown()
                            }
                        Image("arrowLeft")
                            .resizable()
                            .scaledToFit()
                            .frame(height: screenHeight*0.09)
                            .scaleEffect(x: -1)
                            .onTapGesture {
                                stepRight()
                            }
                    }
                }
                .offset(x: -screenWidth*offsetsArray[1])
            }
            
            if youWin {
                MiniWin(youWin: $youWin)
            }
            
        }
        
        .onChange(of: youWin) { _ in
            if !youWin {
                restartGame()
            }
        }
        
        .onChange(of: labyrinthArray) { _ in
            if labyrinthArray[0][0].cube {
                youWin = true
                buttonsSlideOffAnimations()
            }
        }
        
        .onAppear() {
            updateArraysPosibleSteps()
            buttonsAnimations()
        }
    }
    
    func restartGame() {
        labyrinthArray = Arrays.labyrinthArray
        posibleStepsArray = Arrays.posibleStepsArray
        updateArraysPosibleSteps()
        buttonsAnimations()
    }
    
    func updateArraysPosibleSteps() {
        for i in 0..<labyrinthArray.count {
            for j in 0..<labyrinthArray[i].count {
                let posibleStepsData = String(posibleStepsArray[i][j].code).compactMap { $0.wholeNumberValue }
                print(posibleStepsData)
                if posibleStepsData[0] == 1 {
                    labyrinthArray[i][j].left = true
                } else {
                    labyrinthArray[i][j].left = false
                }
                if posibleStepsData[1] == 1 {
                    labyrinthArray[i][j].right = true
                } else {
                    labyrinthArray[i][j].right = false
                }
                if posibleStepsData[2] == 1 {
                    labyrinthArray[i][j].up = true
                } else {
                    labyrinthArray[i][j].up = false
                }
                if posibleStepsData[3] == 1 {
                    labyrinthArray[i][j].down = true
                } else {
                    labyrinthArray[i][j].down = false
                }
            }
        }
    }
    
    func stepLeft() {
        var row = 0
        var col = 0
        for i in 0..<labyrinthArray.count {
            for j in 0..<labyrinthArray[i].count {
                if labyrinthArray[i][j].cube {
                    row = i
                    col = j
                }
            }
        }
        if labyrinthArray[row][col].left {
            labyrinthArray[row][col].cube = false
            withAnimation() {
                labyrinthArray[row][col-1].cube = true
            }
        }
        slide3Opacity = 1
        withAnimation() {
            slide3Opacity = 0
        }
    }
    
    func stepRight() {
        var row = 0
        var col = 0
        for i in 0..<labyrinthArray.count {
            for j in 0..<labyrinthArray[i].count {
                if labyrinthArray[i][j].cube {
                    row = i
                    col = j
                }
            }
        }
        if labyrinthArray[row][col].right {
            labyrinthArray[row][col].cube = false
            withAnimation() {
                labyrinthArray[row][col+1].cube = true
            }
        }
        slide4Opacity = 1
        withAnimation() {
            slide4Opacity = 0
        }
    }
    
    func stepDown() {
        var row = 0
        var col = 0
        for i in 0..<labyrinthArray.count {
            for j in 0..<labyrinthArray[i].count {
                if labyrinthArray[i][j].cube {
                    row = i
                    col = j
                }
            }
        }
        if labyrinthArray[row][col].down {
            labyrinthArray[row][col].cube = false
            withAnimation() {
                labyrinthArray[row+1][col].cube = true
            }
        }
        slide1Opacity = 1
        withAnimation() {
            slide1Opacity = 0
        }
    }
    
    func stepUp() {
        var row = 0
        var col = 0
        for i in 0..<labyrinthArray.count {
            for j in 0..<labyrinthArray[i].count {
                if labyrinthArray[i][j].cube {
                    row = i
                    col = j
                }
            }
        }
        if labyrinthArray[row][col].up {
            labyrinthArray[row][col].cube = false
            withAnimation() {
                labyrinthArray[row-1][col].cube = true
            }
        }
        slide2Opacity = 1
        withAnimation() {
            slide2Opacity = 0
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
    MiniGame4()
}
