//
//  Scores.swift
//  assign1
//
//  Created by Shuo Wang on 5/7/23.
//

import SwiftUI

struct ScoresList: View {
    
    @Environment(\.verticalSizeClass) var orientation: UserInterfaceSizeClass?
    //@ObservedObject var game : Triples
    var game : Triples
    var scores: [Scores]

    var body: some View {
        
        VStack{
            ScrollView{
                VStack {
                    HStack{
                        Text("Scores")
                            .font(Font.system(size:24))
                            .foregroundColor(.black)
                            .padding()
                        Spacer()}
                    HStack {
                        Spacer()
                        VStack{
                            ForEach(0..<game.scores.count, id:\.self) { i  in
                                VStack{
                                    Text("\(game.scores[i].value)")
                                        .font(Font.system(size:15))
                                        .offset(x: orientation == .regular ?  -60 : -180)
                                }
                            }
                        }
                    }
                }
                
            }
            
            
        }
        
    }
}

//struct Scores_Previews: PreviewProvider {
//    static var previews: some View {
//        Scores(scores: [Score])
//    }
//}
