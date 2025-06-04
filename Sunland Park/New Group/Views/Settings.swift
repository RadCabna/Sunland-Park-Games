//
//  Settings.swift
//  Sunland Park
//
//  Created by Алкександр Степанов on 03.06.2025.
//

import SwiftUI

struct Settings: View {
    @EnvironmentObject var coordinator: Coordinator
    @State private var globalOpacity: CGFloat = 0
    @AppStorage("music") var music = true
    @AppStorage("sound") var sound = true
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
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.horizontal)
            .opacity(globalOpacity)
            VStack() {
                Buttons(size: 0.7,text: "SETTINGS")
                    .opacity(globalOpacity)
                    .padding(.top, screenHeight*0.07)
                Spacer()
                Image("settingsFrame")
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight*0.32)
                    .overlay(
                        VStack(spacing: screenHeight*0.05) {
                            HStack {
                                Text("MUSIC")
                                    .font(Font.custom("Patsy Sans", size: screenHeight*0.05))
                                    .foregroundColor(Color("textColor"))
                                    .shadow(color:.black, radius: 3, x: 2, y: 3)
                                Spacer()
                                Image(music ? "settingOn" : "settingOff")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenHeight*0.043)
                            }
                            .padding(.horizontal, screenHeight*0.06)
                            .onTapGesture {
                                    music.toggle()
                            }
                            HStack {
                                Text("SOUND")
                                    .font(Font.custom("Patsy Sans", size: screenHeight*0.05))
                                    .foregroundColor(Color("textColor"))
                                    .shadow(color:.black, radius: 3, x: 2, y: 3)
                                Spacer()
                                Image(sound ? "settingOn" : "settingOff")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: screenHeight*0.043)
                            }
                            .padding(.horizontal, screenHeight*0.06)
                            .onTapGesture {
                                    sound.toggle()
                            }
                        }
                    )
                    .padding(.bottom, screenHeight*0.07)
                Spacer()
            }
            .opacity(globalOpacity)
        }
        
        .onAppear {
            showMenuAnimation()
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
    Settings()
}
