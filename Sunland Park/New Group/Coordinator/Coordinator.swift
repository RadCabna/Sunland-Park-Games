//
//  Coordinator.swift
//  Sunland Park
//
//  Created by Алкександр Степанов on 03.06.2025.
//

import Foundation
import SwiftUI

enum CoordinatorView: Equatable {
    case loading
    case mainMenu
    case settings
    case game
    case bonusGame
    case choseLevel
    case selectShopItem
    case shop
    case selectMiniGames
    case minGame1
    case minGame2
    case minGame3
    case minGame4
    case achievements
}

final class Coordinator: ObservableObject {
    @Published var path: [CoordinatorView] = []
    
    func resolve(pathItem: CoordinatorView) -> AnyView {
        var view = AnyView(Loading())
        switch pathItem {
        case .loading:
            view = AnyView(Loading())
        case .mainMenu:
            view = AnyView(Menu())
        case .game:
            view = AnyView(Game())
        case .bonusGame:
            view = AnyView(BonusGame())
        case .settings:
            view = AnyView(Settings())
        case .choseLevel:
            view = AnyView(ChoseLevel())
        case .selectShopItem:
            view = AnyView(SelectShopItem())
        case .shop:
            view = AnyView(Shop())
        case .selectMiniGames:
            view = AnyView(SelectMiniGames())
        case .minGame1:
            view = AnyView(MiniGame1())
        case .minGame2:
            view = AnyView(MiniGame2())
        case .minGame3:
            view = AnyView(MiniGame3())
        case .minGame4:
            view = AnyView(MiniGame4())
        case .achievements:
            view = AnyView(Achievements())
            
        }
        return view
    }
    
    func navigate(to pathItem: CoordinatorView) {
        path.append(pathItem)
    }
    
    func navigateBack() {
        _ = path.popLast()
    }
}

struct ContentView: View {
    @StateObject private var coordinator = Coordinator()
    
    var body: some View {
        ZStack {
            coordinator.resolve(pathItem: coordinator.path.last ?? .loading)
        }
        .environmentObject(coordinator)
    }
}

#Preview {
    ContentView()
}





