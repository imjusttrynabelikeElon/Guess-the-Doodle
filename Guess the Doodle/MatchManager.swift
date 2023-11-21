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
    
    
    @Published var currentlyDrawing = false
    @Published var drawPrompt = ""
    @Published var pastGuesses = [PastGuess]()
    
    @Published var score = 0
    @Published var remainingTime = maxTimeRemaining
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
            isTimeKeeper = true
            
            if isTimeKeeper {
                countDownTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

            }
        default:
            break
        }
    }
}
