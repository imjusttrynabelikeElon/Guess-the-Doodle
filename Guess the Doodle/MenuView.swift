//
//  MenuView.swift
//  Guess the Doodle
//
//  Created by Karon Bell on 11/19/23.
//

import SwiftUI
//
struct MenuView: View {
    
    
    @ObservedObject var matchManager: MatchManager
    
    
    var body: some View {
        VStack {
           Spacer()
            Image("gameOver")
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 70)
                .padding(.vertical)
            
            Text("Score \(matchManager.score)")
                .font(.largeTitle)
                .bold()
                .foregroundColor(Color("primaryYellow"))
            
            Spacer()
            
            Button {
                matchManager.startMatchMaking()
            } label: {
                Text("Menu")
                    .foregroundColor(Color("menuBtn"))
                    .brightness(-0.4)
                    .font(.largeTitle)
                    .bold()
            }
            
            
         
            
            .padding()
            .padding(.horizontal, 50)
            .background(
                Capsule(style: .circular)
                    .fill(Color("playBtn"))
            )
            
          
            
            Spacer()

        }
        .background(
           Color("menuBg")
             
                .scaledToFill()
                .scaleEffect(1.1)
        )
        .ignoresSafeArea()
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(matchManager: MatchManager())
    }
}
