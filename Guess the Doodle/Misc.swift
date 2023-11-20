//
//  Misc.swift
//  Guess the Doodle
//
//  Created by Karon Bell on 11/19/23.
//

import Foundation
// this was the correct amount of time



// everydayObjects


// array of objects is the correct time


let everydayObjects: [String] = [
    "Table", "Chair", "Pen", "Paper", "Book", "Lamp", "Cup", "Plate", "Knife", "Fork",
    "Spoon", "Glass", "Window", "Door", "Key", "Wallet", "Watch", "Shoes", "Socks", "Hat",
    "Jacket", "Pants", "Shirt", "Towel", "Soap", "Brush", "Mirror", "Computer", "Phone", "Headphones",
    "Remote", "Television", "Radio", "Bottle", "Bag", "Umbrella", "Scissors", "Ruler", "Pencil",
    "Eraser", "Marker", "Calculator", "Glasses", "Sunglasses", "Calendar", "Notepad", "Envelope", "Stapler",
    "Tape", "Glue", "Charger", "Battery", "Clock", "Alarm", "Bed", "Pillow", "Blanket", "Curtains",
    "Carpet", "Rug", "Plant", "Flower", "Vase", "Photo", "Frame", "Album", "Bowl", "Spoon",
    "Fork", "Knife", "Plate", "Cup", "Mug", "Pitcher", "Teapot", "Toaster", "Microwave", "Refrigerator",
    "Freezer", "Oven", "Stove", "Sink", "Faucet", "Dishwasher", "Sponge", "Trashcan", "Broom", "Vacuum",
    "Duster", "Bucket", "Mop", "Laundry", "Basket", "Iron", "Hanger"
]


//

enum PlayerAuthState: String {
    case authenticating = "Logging in to Game Center..."
    case unauthenticated = "Please sign in to Game Center to play."
    case error = "There was an error logging into Game Center."
    case restricted = "You're not allowed to play multiplayer games!"
}




struct PastGuess: Identifiable {
    let id = UUID()
    var message: String
    var correct: Bool
}





let maxTimeRemaining = 100
