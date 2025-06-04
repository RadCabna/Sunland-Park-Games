//
//  Shop.swift
//  Sunland Park
//
//  Created by Алкександр Степанов on 03.06.2025.
//

import SwiftUI

struct Shop: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("coinCount") var coinCount: Int = 0
    @AppStorage("shopType") var shopType = 1
    @AppStorage("bgNumber") var bgNumber = 1
    @AppStorage("instrumentNumber") var instrumentNumber = 1
    @State private var headText = "INSTRUMENTS"
    @State private var offsetsArray: [CGFloat] = [1,-1]
    @State private var globalOpacity: CGFloat = 0
    @State private var shopItemsData = UserDefaults.standard.array(forKey: "shopItemsInstrumentsData") as? [Int] ?? [2,1,0,0]
    @State private var dataName = "shopItemsInstrumentsData"
    @State private var shopArray = Arrays.shopInstrumentsArray
    var body: some View {
        ZStack {
            Background(backgroundNumber: 1)
            HStack {
                Image("backButton")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.06)
                    .onTapGesture {
                        buttonsSlideOffAnimations()
                        closeMenuAnimation()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
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
            VStack(spacing: screenHeight*0.025) {
                Buttons(size: 0.7,text: "SHOP")
                    .padding(.top, screenHeight*0.07)
                Spacer()
                Text("\(headText)")
                    .font(Font.custom("Patsy Sans", size: screenHeight*0.04))
                    .foregroundColor(Color("textColor"))
                    .shadow(color:.black, radius: 3, x: 2, y: 3)
                    .padding(.bottom, screenHeight*0.05)
                    .opacity(globalOpacity)
                HStack(spacing: screenHeight*0.04) {
                    ForEach(0..<2, id: \.self) { item in
                        VStack {
                            if shopType == 1 {
                                Image("shopInstrumentFrame")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenHeight*0.15)
                                    .overlay(
                                        Image(shopArray[item].name)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: screenHeight*0.13, maxHeight: screenHeight*0.1)
                                    )
                            } else {
                                Image(shopArray[item].name)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenHeight*0.15)
                            }
                            if shopItemsData[item] == 0 {
                                Image("pricePlate")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenHeight*0.05)
                                    .onTapGesture {
                                        buyItem(item: item)
                                    }
                            }
                            if shopItemsData[item] == 1 {
                                Image("setButton")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenHeight*0.05)
                                    .onTapGesture {
                                        selectItem(item: item)
                                    }
                            }
                            if shopItemsData[item] == 2 {
                                Image("useButton")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenHeight*0.05)
                            }
                        }
                    }
                }
                .offset(x: -screenWidth*offsetsArray[0])
                HStack(spacing: screenHeight*0.04) {
                    ForEach(2..<4, id: \.self) { item in
                        VStack {
                            if shopType == 1 {
                            Image("shopInstrumentFrame")
                                .resizable()
                                .scaledToFit()
                                .frame(height: screenHeight*0.15)
                                .overlay(
                                    Image(shopArray[item].name)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(maxWidth: screenHeight*0.13, maxHeight: screenHeight*0.1)
                                )
                            } else {
                                Image(shopArray[item].name)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenHeight*0.15)
                            }
                            if shopItemsData[item] == 0 {
                                Image("pricePlate")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenHeight*0.05)
                                    .onTapGesture {
                                        buyItem(item: item)
                                    }
                            }
                            if shopItemsData[item] == 1 {
                                Image("setButton")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenHeight*0.05)
                                    .onTapGesture {
                                        selectItem(item: item)
                                    }
                            }
                            if shopItemsData[item] == 2 {
                                Image("useButton")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenHeight*0.05)
                            }
                        }
                    }
                }
                .offset(x: -screenWidth*offsetsArray[1])
                Spacer()
            }
        }
        
        .onAppear {
            showMenuAnimation()
            buttonsAnimations()
            updateShopArray()
        }
        
    }
    
    func buyItem(item: Int) {
        if coinCount >= shopArray[item].cost {
            coinCount -= shopArray[item].cost
            shopItemsData[item] = 1
            UserDefaults.standard.set(shopItemsData, forKey: dataName)
        }
    }
    
    func selectItem(item: Int) {
            if shopType == 1 {
                bgNumber = item + 1
            } else {
                instrumentNumber = item + 1
            }
        for i in 0..<shopItemsData.count {
            if shopItemsData[i] == 2 {
                shopItemsData[i] = 1
            }
        }
        shopItemsData[item] = 2
            UserDefaults.standard.set(shopItemsData, forKey: dataName)
        
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
    
    func updateShopArray() {
        switch shopType {
        case 1:
            headText = "INSTRUMENTS"
            shopArray = Arrays.shopInstrumentsArray
            dataName = "shopItemsInstrumentsData"
            shopItemsData = UserDefaults.standard.array(forKey: "shopItemsInstrumentsData") as? [Int] ?? [2,0,0,0]
        default:
            headText = "LOCATION"
            shopArray = Arrays.shopBackgroundArray
            dataName = "shopBackgroundData"
            shopItemsData = UserDefaults.standard.array(forKey: "shopBackgroundData") as? [Int] ?? [2,0,0,0]
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
    Shop()
}
