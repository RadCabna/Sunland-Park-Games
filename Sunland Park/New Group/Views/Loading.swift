//
//  Loading.swift
//  Sunland Park
//
//  Created by Алкександр Степанов on 03.06.2025.
//

import SwiftUI

struct Loading: View {
    @EnvironmentObject var coordinator: Coordinator
    @AppStorage("levelInfo") var level = false
    @State private var loadingProgress: CGFloat = 1
    @State private var logoOpacity: CGFloat = 0
    var body: some View {
        GeometryReader { geometry in
            let height = geometry.size.height
            let width = geometry.size.width
            let isLandscape = width > height
            if isLandscape {
                ZStack {
                    Background(backgroundNumber: 1)
                    VStack {
                        Spacer()
                        Image("loadingLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: width*0.35)
                        Spacer()
                        Text("LOADING...")
                            .font(Font.custom("Patsy Sans", size: width*0.035))
                            .foregroundColor(Color("textColor"))
                            .shadow(color: Color("textShadowColor"), radius: width*0.001)
                            .shadow(color: Color("textShadowColor"), radius: width*0.001)
                        ZStack {
                            Image("loadingBarBack")
                                .resizable()
                                .scaledToFit()
                                .frame(width: height*0.8)
                            Image("loadingBarFront")
                                .resizable()
                                .scaledToFit()
                                .frame(width: height*0.78)
                                .offset(x: -height*0.78*loadingProgress)
                                .mask(
                                    Image("loadingBarFront")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: height*0.74)
                                )
                        }
                        .padding(.bottom, width*0.05)
                    }
                    .opacity(logoOpacity)
                    .rotationEffect(Angle(degrees: 90))
                }
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            } else {
                ZStack {
                    Background(backgroundNumber: 1)
                    VStack {
                        Spacer()
                        Image("loadingLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: height*0.45)
                        Spacer()
                        Text("LOADING...")
                            .font(Font.custom("Patsy Sans", size: height*0.035))
                            .foregroundColor(Color("textColor"))
                            .shadow(color: Color("textShadowColor"), radius: height*0.001)
                            .shadow(color: Color("textShadowColor"), radius: height*0.001)
                        ZStack {
                            Image("loadingBarBack")
                                .resizable()
                                .scaledToFit()
                                .frame(width: width*0.8)
                            Image("loadingBarFront")
                                .resizable()
                                .scaledToFit()
                                .frame(width: width*0.78)
                                .offset(x: -width*0.78*loadingProgress)
                                .mask(
                                    Image("loadingBarFront")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: width*0.78)
                                )
                        }
                        .padding(.bottom, height*0.05)
                    }
                    .opacity(logoOpacity)
                }
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
        }
        
        .onChange(of: level) { _ in
            if level {
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    coordinator.navigate(to: .mainMenu)
                }
            }
        }
        
        .onAppear {
            loadingProgressAnimation()
        }
        
    }
    
    func loadingProgressAnimation() {
        withAnimation(Animation.easeInOut(duration: 1)) {
            logoOpacity = 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(Animation.easeInOut(duration: 4)) {
                loadingProgress = 0
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            coordinator.navigate(to: .mainMenu)
        }
    }
    
}

#Preview {
    Loading()
}
