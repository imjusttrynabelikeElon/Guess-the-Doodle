//
//  ContentView.swift
//  Guess the Doodle
//
//  Created by Karon Bell on 11/19/23.
//

import SwiftUI
//
struct ContentView: View {
    @StateObject var matchManager = MatchManager()
    
    var body: some View {
        
        ZStack {
            if matchManager.isGameOver {
                GameView(matchManager: matchManager)
            } else if matchManager.inGame {
                GameView(matchManager: matchManager)
            } else {
                MenuView(matchManager: matchManager)
            }
        }
        .onAppear {
            matchManager.authenticateUser()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
