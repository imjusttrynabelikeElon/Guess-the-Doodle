//
//  MatchManager.swift
//  Guess the Doodle
//
//  Created by Karon Bell on 11/19/23.
//
//
import Foundation
import GameKit
import PencilKit



class MatchManager: NSObject, ObservableObject {
    @Published var authenticationState = PlayerAuthState.authenticating
    
    @Published var inGame = false
    
    
    @Published var isGameOver = false
    
    
    @Published var currentlyDrawing = true
    @Published var drawPrompt = ""
    @Published var pastGuesses = [PastGuess]()
    
    @Published var score = 0
    @Published var remainingTime = maxTimeRemaining {
        willSet {
            if isTimeKeeper { sendString("timer:\(newValue)") }
                                         if newValue < 0 {gameOver() }
        }
    }
    @Published var lastReceivedDrawing = PKDrawing()
    
    
    
    @Published var isTimeKeeper = false
    var match: GKMatch?
    var otherPlayer: GKPlayer?
    var locallayer = GKLocalPlayer.local
    
    var playerUUIDKey = UUID().uuidString
    
    var rootVC: UIViewController? {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return windowScene?.windows.first?.rootViewController
    }
    
    func authenticateUser() {
        GKLocalPlayer.local.authenticateHandler = { [self] vc, e in
            if let viewController = vc {
                rootVC?.present(viewController, animated: true)
                return
            }
            if let error = e {
                authenticationState = .error
                print(error.localizedDescription)
                
                return
            }
            if locallayer.isAuthenticated {
                if locallayer.isMultiplayerGamingRestricted {
                    authenticationState = .restricted
                  
                } else {
                    authenticationState = .authenticating
                }
                
            }   else {
                authenticationState = .unauthenticated
            }
        }
    }
    
    func startMatchMaking() {
        let request = GKMatchRequest()
        request.minPlayers = 2
        request.maxPlayers = 2
        
        let matchMakingVC = GKMatchmakerViewController(matchRequest: request)
        matchMakingVC?.matchmakerDelegate = self
      
        
        
        rootVC?.present(matchMakingVC!, animated: true)
    }
    
    func startGame(newMatch: GKMatch) {
        match = newMatch
        match?.delegate = self
        otherPlayer = match?.players.first
        drawPrompt = everydayObjects.randomElement()!
        
        sendString("began:\(playerUUIDKey)")
    }
    
    func swapRoles() {
        score += 1
        currentlyDrawing = !currentlyDrawing
        drawPrompt = everydayObjects.randomElement()!
    }
    
    func gameOver() {
        isGameOver = true
        match?.disconnect()
    }
    
    func resetGame() {
        DispatchQueue.main.async { [self] in
            isGameOver = false
            inGame = false
            drawPrompt = ""
            score = 0
            remainingTime = maxTimeRemaining
            lastReceivedDrawing = PKDrawing()
            
        }
        
        isTimeKeeper = false
        match?.delegate = nil
        match = nil
        otherPlayer = nil
        pastGuesses.removeAll()
        playerUUIDKey = UUID().uuidString
    }
    
    func receivedString(_ message: String) {
        let messageSplit = message.split(separator: ":")
        guard let messagePrefix = messageSplit.first else { return }
        
        let parmeter = String(messageSplit.last ?? "")
        
        switch messagePrefix {
        case "began":
            if playerUUIDKey == parmeter {
                playerUUIDKey = UUID().uuidString
                sendString("began:\(playerUUIDKey)")
                break
            }
            currentlyDrawing = playerUUIDKey < parmeter
            inGame = true
            isTimeKeeper = currentlyDrawing
            
            if isTimeKeeper {
                countDownTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

            }
        case "guess":
            var guessCorrect = false
            
            if parmeter.lowercased() == drawPrompt {
                sendString("correct:\(parmeter)")
                swapRoles()
                guessCorrect = true
            } else {
                sendString("incorrect:\(parmeter)")
            }
            
            appendPastGuess(guess: parmeter, correct: guessCorrect)
        case "correct":
            swapRoles()
            appendPastGuess(guess: parmeter, correct: true)
        case "incorrect":
            appendPastGuess(guess: parmeter, correct: false)
        case "timer:":
            remainingTime = Int(parmeter) ?? 0
        default:
            break
        }
    }
    
    func appendPastGuess(guess: String, correct: Bool) {
        pastGuesses.append(PastGuess(message: "\(guess)\(correct ? " was correct!" : "")", correct: correct))
    }
}
