//
//  ContentView.swift
//  assign1
//
//  Created by Shuo Wang on 5/3/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var game: Triples
   // var game: Triples = Triples()
    var body: some View {
        TabView {
            BoardView().tabItem {
                Label("Board", systemImage: "gamecontroller")
            }
            
            ScoresList(game: game,scores: game.sortScores(score_list: game.scores) ).tabItem {
                Label("Scores", systemImage: "list.dash")
            
            }
            .onAppear(){
                //game.scores.append(Scores(score: game.score, time: Date()))
                print(game.scores)
            }
            About().tabItem {
                Label("About", systemImage: "info.circle")
            }
        }

    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

