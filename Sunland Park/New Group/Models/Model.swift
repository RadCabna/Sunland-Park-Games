//
//  Model.swift
//  Sunland Park
//
//  Created by Алкександр Степанов on 03.06.2025.
//

import Foundation

struct ShopItem {
    var name: String
    var cost: Int
}

struct MiniGFour: Equatable {
    var cube = false
    var left = false
    var right = false
    var up = false
    var down = false
}

struct Step: Equatable {
    var code: String
}

struct Cards: Equatable {
    var name: String
    var open = false
    var correct = false
}

class Arrays {
    
    static var cardLogoArray: [String] = ["figure1", "figure2", "figure3", "figure4", "figure5", "figure6"]
    
    static var cardsArray: [Cards] = [
        Cards(name: "figure1"),
        Cards(name: "figure2"),
        Cards(name: "figure3"),
        Cards(name: "figure4"),
        Cards(name: "figure5"),
        Cards(name: "figure6")
    ]
    
    static var shopBackgroundArray: [ShopItem] = [
        ShopItem(name: "shopLocation1", cost: 0),
        ShopItem(name: "shopLocation2", cost: 500),
        ShopItem(name: "shopLocation3", cost: 500),
        ShopItem(name: "shopLocation4", cost: 500)
    ]
    
    static var shopInstrumentsArray: [ShopItem] = [
        ShopItem(name: "shopInsrument1", cost: 0),
        ShopItem(name: "shopInsrument2", cost: 500),
        ShopItem(name: "shopInsrument3", cost: 500),
        ShopItem(name: "shopInsrument4", cost: 500)
    ]
    
    static var achievementsTextArray = [
        "Catch 10 notes in a row without making a mistake",
        "Complete 3 levels in a row without making any mistakes",
        "Catch 5 notes in 5 seconds",
        "Catch 10 notes in 10 seconds",
        "Complete 5 levels in a row without making any mistakes"
    ]
    
    static var labyrinthArray: [[MiniGFour]] = [
        [MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour()],
        [MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour()],[MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour()],[MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour()],[MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour()],[MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour()],[MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour()],[MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour()],[MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour()],[MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour()],[MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour()],[MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour()],[MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour()],[MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour()],[MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour()]
    ]
    
//    static var posibleStepsArray: [[Step]] = [
//        [Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>)],
//        [Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>)],
//        [Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>)],
//        [Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>)],
//        [Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>)],
//        [Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>)],
//        [Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>)],
//        [Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>)],
//        [Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>)],
//        [Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>)],
//        [Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>)],
//        [Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>)],
//        [Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>)],
//        [Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>)],
//        [Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>),Step(code: <#T##String#>)],
//    ]
}
