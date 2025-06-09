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
    var guitar = false
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

struct BonusQoestion: Equatable {
    var question: String
    var variant: [String]
    var correctAnswer: String
}

struct DropItem: Equatable {
    var name: String
    var yOffset: CGFloat
    var xOffset: CGFloat = 0
    var timer: Timer? = nil
    var dropTime = 0.02
    var delay: Double
    var collected: Bool = false
    var opacity: CGFloat = 1
    var colorType = 1
}

struct NoteType: Equatable {
    var name: String
    var colorType: Int
}

struct GameColorCirsle: Equatable {
    var colorType: Int
    var name: String
}

class Arrays {
    
    static var dropBonus: DropItem = DropItem(name: "bonusItem", yOffset: -0.7, delay: 0)
    
    static var colorCircleArray: [GameColorCirsle] = [
        GameColorCirsle(colorType: 1, name: "blueCircle"),
        GameColorCirsle(colorType: 2, name: "greenCircle"),
        GameColorCirsle(colorType: 3, name: "redCircle"),
        GameColorCirsle(colorType: 4, name: "violetCircle"),
        GameColorCirsle(colorType: 5, name: "yellowCircle"),
    ]
    
    static var blueNotes: [NoteType] = [
        NoteType(name: "blueNote1", colorType: 1),
        NoteType(name: "blueNote2", colorType: 1),
        NoteType(name: "blueNote3", colorType: 1),
        NoteType(name: "blueNote4", colorType: 1),
        NoteType(name: "blueNote5", colorType: 1),
        NoteType(name: "blueNote6", colorType: 1),
    ]
    
    static var greenNotes: [NoteType] = [
        NoteType(name: "greenNote1", colorType: 2),
        NoteType(name: "greenNote2", colorType: 2),
        NoteType(name: "greenNote3", colorType: 2),
        NoteType(name: "greenNote4", colorType: 2),
        NoteType(name: "greenNote5", colorType: 2),
        NoteType(name: "greenNote6", colorType: 2),
        ]
    
    static var redNotes: [NoteType] = [
        NoteType(name: "redNote1", colorType: 3),
        NoteType(name: "redNote2", colorType: 3),
        NoteType(name: "redNote3", colorType: 3),
        NoteType(name: "redNote4", colorType: 3),
        NoteType(name: "redNote5", colorType: 3),
        NoteType(name: "redNote6", colorType: 3)
        ]
    
    static var violetNotes: [NoteType] = [
        NoteType(name: "violetNote1", colorType: 4),
        NoteType(name: "violetNote2", colorType: 4),
        NoteType(name: "violetNote3", colorType: 4),
        NoteType(name: "violetNote4", colorType: 4),
        NoteType(name: "violetNote5", colorType: 4),
        NoteType(name: "violetNote6", colorType: 4)
        ]
    
    static var yellowNotes: [NoteType] = [
        NoteType(name: "yellowNote1", colorType: 5),
        NoteType(name: "yellowNote2", colorType: 5),
        NoteType(name: "yellowNote3", colorType: 5),
        NoteType(name: "yellowNote4", colorType: 5),
        NoteType(name: "yellowNote5", colorType: 5),
        NoteType(name: "yellowNote6", colorType: 5)
        ]
    
    static var allNotesArray = [
        blueNotes,
        greenNotes,
        redNotes,
        violetNotes,
        yellowNotes
    ]
    
    static var gameItemsArray: [DropItem] = [
        DropItem(name: "yellowNote1", yOffset: -0.7, delay: 1),
        DropItem(name: "yellowNote1", yOffset: -0.7, delay: 0),
        DropItem(name: "yellowNote1", yOffset: -0.7, delay: 2),
        DropItem(name: "yellowNote1", yOffset: -0.7, delay: 2),
    ]
    
    static var bonusQuestionArray: [BonusQoestion] = [
        BonusQoestion(question: "Who performed the hit \nsong ‘Shape of You’?", variant: ["Justin Bieber", "Ed Sheeran", "Sam Smith"], correctAnswer: "Ed Sheeran"),
        BonusQoestion(question: "Which of the following \ninstruments is a string \ninstrument?", variant: ["Drum", "Violin", "Trumpet"], correctAnswer: "Violin"),
        BonusQoestion(question: "Which of the following \ninstruments has keys \nand strings?", variant: ["Piano", "Saxophone", "Guitar"], correctAnswer: "Piano")
]
    
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
        "Catch 10 notes in a row \nwithout making a mistake",
        "Complete 3 levels in a row \nwithout making any mistakes",
        "Catch 5 notes in 5 seconds",
        "Catch 10 notes in \n10 seconds",
        "Complete 5 levels in a row \nwithout making any \nmistakes"
    ]
    
    static var labyrinthArray: [[MiniGFour]] = [
        [MiniGFour(guitar: true),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(cube: true),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour()],
        [MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour()],
        [MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour()],
        [MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour()],
        [MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour()],
        [MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour()],
        [MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour()],
        [MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour()],
        [MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour()],
        [MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour()],
        [MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour()],
        [MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour(),MiniGFour()]
    ]
    
    static var posibleStepsArray: [[Step]] = [
        [Step(code: "0001"),Step(code: "0101"),Step(code: "1000"),Step(code: "0101"),Step(code: "1100"),Step(code: "1101"),Step(code: "1100"),Step(code: "1100"),Step(code: "1001"),Step(code: "0100"),Step(code: "1100"),Step(code: "1010")],
        [Step(code: "0011"),Step(code: "0111"),Step(code: "1100"),Step(code: "1010"),Step(code: "0101"),Step(code: "1010"),Step(code: "0100"),Step(code: "1100"),Step(code: "1110"),Step(code: "1100"),Step(code: "1001"),Step(code: "0011")],
        [Step(code: "0011"),Step(code: "0110"),Step(code: "1100"),Step(code: "1001"),Step(code: "0110"),Step(code: "1100"),Step(code: "1100"),Step(code: "1100"),Step(code: "1001"),Step(code: "0010"),Step(code: "0110"),Step(code: "1011")],
        [Step(code: "0110"),Step(code: "1100"),Step(code: "1001"),Step(code: "0110"),Step(code: "1001"),Step(code: "0100"),Step(code: "1101"),Step(code: "1001"),Step(code: "0011"),Step(code: "0111"),Step(code: "1000"),Step(code: "0011")],
        [Step(code: "0101"),Step(code: "1000"),Step(code: "0011"),Step(code: "0001"),Step(code: "0110"),Step(code: "1100"),Step(code: "1010"),Step(code: "0011"),Step(code: "0011"),Step(code: "0111"),Step(code: "1001"),Step(code: "0011")],
        [Step(code: "0011"),Step(code: "0101"),Step(code: "1010"),Step(code: "0011"),Step(code: "0101"),Step(code: "1101"),Step(code: "1000"),Step(code: "0011"),Step(code: "0011"),Step(code: "0010"),Step(code: "0110"),Step(code: "1010")],
        [Step(code: "0011"),Step(code: "0011"),Step(code: "0001"),Step(code: "0111"),Step(code: "1010"),Step(code: "0110"),Step(code: "1100"),Step(code: "1010"),Step(code: "0110"),Step(code: "1001"),Step(code: "0101"),Step(code: "1001")],
        [Step(code: "0011"),Step(code: "0011"),Step(code: "0011"),Step(code: "0011"),Step(code: "0101"),Step(code: "1100"),Step(code: "1001"),Step(code: "0100"),Step(code: "1000"),Step(code: "0110"),Step(code: "1010"),Step(code: "0011")],
        [Step(code: "0011"),Step(code: "0011"),Step(code: "0111"),Step(code: "1110"),Step(code: "1010"),Step(code: "0100"),Step(code: "1110"),Step(code: "1001"),Step(code: "0011"),Step(code: "0101"),Step(code: "1100"),Step(code: "1011")],
        [Step(code: "0011"),Step(code: "0011"),Step(code: "0011"),Step(code: "0101"),Step(code: "1100"),Step(code: "1001"),Step(code: "0101"),Step(code: "1010"),Step(code: "0011"),Step(code: "0011"),Step(code: "0100"),Step(code: "1010")],
        [Step(code: "0011"),Step(code: "0011"),Step(code: "0010"),Step(code: "0011"),Step(code: "0101"),Step(code: "1010"),Step(code: "0110"),Step(code: "1100"),Step(code: "1010"),Step(code: "0110"),Step(code: "1100"),Step(code: "1001")],
        [Step(code: "0110"),Step(code: "1110"),Step(code: "1100"),Step(code: "1010"),Step(code: "0110"),Step(code: "1100"),Step(code: "1100"),Step(code: "1100"),Step(code: "1100"),Step(code: "1100"),Step(code: "1100"),Step(code: "1010")],
    ]
}
