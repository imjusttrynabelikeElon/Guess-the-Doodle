//
//  MatchManager.swift
//  Guess the Doodle
//
//  Created by Karon Bell on 11/19/23.
//
//
import Foundation




class MatchManager: ObservableObject {
    @Published var authenticationState = PlayerAuthState.authenticating
    
    @Published var inGame = false
    
    
    @Published var isGameOver = false
    
    
    @Published var currentlyDrawing = false
    @Published var drawPrompt = ""
    @Published var pastGuesses = [PastGuess]()
    
    @Published var score = 0
    @Published var remainingTime = maxTimeRemaining
}
