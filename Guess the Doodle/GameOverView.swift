//
//  GameOverView.swift
//  Guess the Doodle
//
//  Created by Karon Bell on 11/19/23.
//

import SwiftUI

struct GameOverView: View {
    
    
    @ObservedObject var matchManager: MatchManager
    var body: some View {
        VStack {
           Spacer()
            Text("GAME OVER!")
                           .font(.title)
                           .fontWeight(.bold)
                           .foregroundColor(Color.white)
           
            
            Spacer()
   //
            Button {
                matchManager.resetGame()
            } label: {
                Text("PLAY")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .bold()
            }
            
            
            .disabled(matchManager.authenticationState != .unauthenticated || matchManager.inGame)
            .padding(.vertical, 20)
            .padding(.horizontal, 100)
            .background(
                Capsule(style: .circular)
                    .fill(matchManager.authenticationState != .unauthenticated || matchManager.inGame  ? .gray : Color("playBtn"))
            )
            
            Text(matchManager.authenticationState.rawValue)
                .font(.headline.weight(.semibold))
                .foregroundColor(Color("primaryYellow"))
                .padding()
            Spacer()

        }
        .background(
           Color("gameOverBg")
               
           
           
                .scaledToFill()
                .scaleEffect(1.1)
        )
        .ignoresSafeArea()
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView(matchManager: MatchManager())
    }
}
