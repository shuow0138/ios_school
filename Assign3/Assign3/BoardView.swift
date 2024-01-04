//
//  BoardView.swift
//  assign1
//
//  Created by Shuo Wang on 5/7/23.
//

import SwiftUI

struct BoardView: View {
    @Environment(\.verticalSizeClass) var orientation: UserInterfaceSizeClass?
    @EnvironmentObject var game: Triples
    //@EnvironmentObject var game: Triples
    
    @State private var selection = "Random"
    @State private var random = true
    @State private var offsetU = false
    @State private var offsetD = false
    @State private var offsetL = false
    @State private var offsetR = false
    @State private var end = false
    @State private var score = Scores(score: 0, time: Date())
    var drag: some Gesture {
        DragGesture(minimumDistance: 0.0, coordinateSpace: .global)
            .onEnded { v in
            }
    }
    
    var body: some View {
        
        if orientation == .regular{
            
       
        VStack(){
            
            //Score
            Text("Score: \(game.score)")
                .font(.title)
                .fontWeight(.bold)
            
            // Game board
            HStack(spacing: 20){
                Spacer(minLength: 0.05)
                VStack(spacing: 20){
                    Spacer(minLength: 0.05)
                    ForEach(0..<4) { row in
                        HStack(spacing: 20) {
                            ForEach(0..<4) { col in
                                TileView(tile: (game.board[row][col] ?? Tile(val: 0, id: 0, row: 0, col: 0)))
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(10)
                                    .offset(x: offsetL ? -5 : offsetR ? 5 : 0,
                                            y: offsetU ? -5 : offsetD ? 5 : 0)
                            }
                        }
                    }
                    Spacer(minLength: 0.05)
                }
                Spacer(minLength: 0.05)
            }
            
            .background(Color.gray)
            .padding().offset(x: 0, y: 0)
            .offset(x: offsetL ? -5 : offsetR ? 5 : 0,
                    y: offsetU ? -5 : offsetD ? 5 : 0 )
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onEnded({ value in
                    if value.translation.width < 0 && value.translation.height > -30 && value.translation.height < 30 {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)) {
                            if game.collapse(dir: .left){
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)) {
                                    self.offsetL = false
                                    self.offsetR = true
                                    self.offsetU = false
                                    self.offsetD = false
                                    game.spawn()
                                }
                                
                            }
                        }
                    }
                    
                    else if value.translation.width > 0 && value.translation.height > -30 && value.translation.height < 30 {
                        // right
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)) {
                            if game.collapse(dir: .right){
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)) {
                                    self.offsetL = false
                                    self.offsetR = true
                                    self.offsetU = false
                                    self.offsetD = false
                                    game.spawn()
                                }
                                
                            }
                        }
                        
                    }
                    else if value.translation.height < 0 && value.translation.width < 100 && value.translation.width > -100 {
                        // up
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)) {
                            if game.collapse(dir: .up){
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)) {
                                    self.offsetL = false
                                    self.offsetR = true
                                    self.offsetU = false
                                    self.offsetD = false
                                    game.spawn()
                                }
                                
                            }
                        }
                        
                    }
                    
                    else if value.translation.height > 0 && value.translation.width < 100 && value.translation.width > -100 {
                        
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)) {
                            if game.collapse(dir: .down){
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)) {
                                    self.offsetL = false
                                    self.offsetR = true
                                    self.offsetU = false
                                    self.offsetD = false
                                    game.spawn()
                                }
                                
                            }
                        }
                    }
                }))
            
            
            
            Button(action: {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)) {
                    if game.collapse(dir: .up){
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)) {
                            game.spawn()
                        }
                        
                    }else{
                        end = game.isGameDone()
                    }
                }
                
            }, label: {
                Text("Up")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.blue)
                    .cornerRadius(10)
            }).alert(isPresented: $end) {
                Alert(title: Text("Game Over"),
                      message: Text("Your score is \(game.score)"),
                      dismissButton: .default(Text("Close and New Game"), action: {
                    
                    game.restart(rand: random)
                }))
            }
            
            HStack() {
                Button(action: {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)) {
                        if game.collapse(dir: .left){
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)) {
                                game.spawn()
                            }
                            
                        }else{
                            end = game.isGameDone()
                        }
                    }
                    
                }, label: {
                    Text("Left")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.blue)
                        .cornerRadius(10)
                }).alert(isPresented: $end) {
                    Alert(title: Text("Game Over"),
                          message: Text("Your score is \(game.score)"),
                          dismissButton: .default(Text("Close and New Game"), action: {
                        
                        game.restart(rand: random)
                    }))
                }
                
                Button(action: {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)) {
                        if game.collapse(dir: .right){
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)) {
                                game.spawn()
                            }
                            
                        }else{
                            end = game.isGameDone()
                        }
                    }
                }, label: {
                    Text("Right")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.blue)
                        .cornerRadius(10)
                }).alert(isPresented: $end) {
                    Alert(title: Text("Game Over"),
                          message: Text("Your score is \(game.score)"),
                          dismissButton: .default(Text("Close and New Game"), action: {
                        
                        game.restart(rand: random)
                    }))
                }
            }
            
            
            Button(action: {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)) {
                    if game.collapse(dir: .down){
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)) {
                            game.spawn()
                        }
                        
                    }else{
                        end = game.isGameDone()
                    }
                }
            }, label: {
                Text("Down")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.blue)
                    .cornerRadius(10)
            }).alert(isPresented: $end) {
                Alert(title: Text("Game Over"),
                      message: Text("Your score is \(game.score)"),
                      dismissButton: .default(Text("Close and New Game"), action: {
                    
                    game.restart(rand: random)
                    end = false
                }))
            }
            
            Button(action: {
                end = true
            }, label: {
                Text("New Game")
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    .background(Color.blue)
                    .cornerRadius(20)
            }).alert(isPresented: $end) {
                Alert(title: Text("Game Over"),
                      message: Text("Your score is \(game.score)"),
                      dismissButton: .default(Text("Close and New Game"), action: {
                    game.restart(rand: random)
                }))
            }
            
            Picker("Mode", selection: $selection) {
                Text("Random").tag("Random")
                Text("Determine").tag("Determine")
            }.pickerStyle(SegmentedPickerStyle())
                .onChange(of: selection) { value in
                    if value == "Random" {
                        random = true
                        end = true
                    } else {
                        random = false
                        end = true
                        
                    }
                }
                .alert(isPresented: $end) {
                    Alert(title: Text("Game Over"),
                          message: Text("Your score is \(game.score)"),
                          dismissButton: .default(Text("Close and New Game"), action: {
                        game.restart(rand: random)
                    }))
                }
            
            //       else{}
        }
        }else{
            VStack{
                HStack{
                    //board
                        
                        VStack(){
                            //Spacer(minLength: 0.05)
                            ForEach(0..<4) { row in
                                HStack() {
                                    ForEach(0..<4) { col in
                                        TileView(tile: (game.board[row][col] ?? Tile(val: 0, id: 0, row: 0, col: 0)))
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .frame(width: 40, height: 40)
                                            .cornerRadius(10)
                                            .offset(x: offsetL ? -5 : offsetR ? 5 : 0,
                                                    y: offsetU ? -5 : offsetD ? 5 : 0)
                                    }
                                }
                                //Spacer(minLength: 0.05)
                            }
                            //Spacer(minLength: 0.05)
                            
                        }
                        
                    
                .background(Color.gray)
                    //.frame(width: 60, height: 60)
                    .padding().offset(x: 0, y: 0)
                    .offset(x: offsetL ? -5 : offsetR ? 5 : 0,
                            y: offsetU ? -5 : offsetD ? 5 : 0 )
                    .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                        .onEnded({ value in
                            if value.translation.width < 0 && value.translation.height > -30 && value.translation.height < 30 {
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)) {
                                    if game.collapse(dir: .left){
                                        withAnimation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)) {
                                            self.offsetL = false
                                            self.offsetR = true
                                            self.offsetU = false
                                            self.offsetD = false
                                            game.spawn()
                                        }
                                        
                                    }
                                }
                            }
                            
                            else if value.translation.width > 0 && value.translation.height > -30 && value.translation.height < 30 {
                                // right
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)) {
                                    if game.collapse(dir: .right){
                                        withAnimation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)) {
                                            self.offsetL = false
                                            self.offsetR = true
                                            self.offsetU = false
                                            self.offsetD = false
                                            game.spawn()
                                        }
                                        
                                    }
                                }
                                
                            }
                            else if value.translation.height < 0 && value.translation.width < 100 && value.translation.width > -100 {
                                // up
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)) {
                                    if game.collapse(dir: .up){
                                        withAnimation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)) {
                                            self.offsetL = false
                                            self.offsetR = true
                                            self.offsetU = false
                                            self.offsetD = false
                                            game.spawn()
                                        }
                                        
                                    }
                                }
                                
                            }
                            
                            else if value.translation.height > 0 && value.translation.width < 100 && value.translation.width > -100 {
                                
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)) {
                                    if game.collapse(dir: .down){
                                        withAnimation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)) {
                                            self.offsetL = false
                                            self.offsetR = true
                                            self.offsetU = false
                                            self.offsetD = false
                                            game.spawn()
                                        }
                                        
                                    }
                                }
                            }
                        }))
                    
                    VStack{
                        //Score
                        Text("Score: \(game.score)")
                            .font(.title)
                            .fontWeight(.bold)
                       //Up
                        Button(action: {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)) {
                                if game.collapse(dir: .up){
                                    withAnimation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)) {
                                        game.spawn()
                                    }
                                    
                                }else{
                                    end = game.isGameDone()
                                }
                            }
                            
                        }, label: {
                            Text("Up")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }).alert(isPresented: $end) {
                            Alert(title: Text("Game Over"),
                                  message: Text("Your score is \(game.score)"),
                                  dismissButton: .default(Text("Close and New Game"), action: {
                                
                                game.restart(rand: random)
                            }))
                        }
                        
                        HStack() {
                            Button(action: {
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)) {
                                    if game.collapse(dir: .left){
                                        withAnimation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)) {
                                            game.spawn()
                                        }
                                        
                                    }else{
                                        end = game.isGameDone()
                                    }
                                }
                                
                            }, label: {
                                Text("Left")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }).alert(isPresented: $end) {
                                Alert(title: Text("Game Over"),
                                      message: Text("Your score is \(game.score)"),
                                      dismissButton: .default(Text("Close and New Game"), action: {
                                    
                                    game.restart(rand: random)
                                }))
                            }
                            
                            Button(action: {
                                withAnimation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)) {
                                    if game.collapse(dir: .right){
                                        withAnimation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)) {
                                            game.spawn()
                                        }
                                        
                                    }else{
                                        end = game.isGameDone()
                                    }
                                }
                            }, label: {
                                Text("Right")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }).alert(isPresented: $end) {
                                Alert(title: Text("Game Over"),
                                      message: Text("Your score is \(game.score)"),
                                      dismissButton: .default(Text("Close and New Game"), action: {
                                    
                                    game.restart(rand: random)
                                }))
                            }
                        }
                        
                        
                        Button(action: {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)) {
                                if game.collapse(dir: .down){
                                    withAnimation(.spring(response: 0.4, dampingFraction: 0.5, blendDuration: 0.5)) {
                                        game.spawn()
                                    }
                                    
                                }else{
                                    end = game.isGameDone()
                                }
                            }
                        }, label: {
                            Text("Down")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }).alert(isPresented: $end) {
                            Alert(title: Text("Game Over"),
                                  message: Text("Your score is \(game.score)"),
                                  dismissButton: .default(Text("Close and New Game"), action: {
                                
                                game.restart(rand: random)
                                end = false
                            }))
                        }
                        //Down
                        Button(action: {
                            end = true
                        }, label: {
                            Text("New Game")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                                .background(Color.blue)
                                .cornerRadius(20)
                        }).alert(isPresented: $end) {
                            Alert(title: Text("Game Over"),
                                  message: Text("Your score is \(game.score)"),
                                  dismissButton: .default(Text("Close and New Game"), action: {
                                game.restart(rand: random)
                            }))
                        }
                        
                        
                    }
                }
                Picker("Mode", selection: $selection) {
                    Text("Random").tag("Random")
                    Text("Determine").tag("Determine")
                }.pickerStyle(SegmentedPickerStyle())
                    .onChange(of: selection) { value in
                        if value == "Random" {
                            random = true
                            end = true
                        } else {
                            random = false
                            end = true
                            
                        }
                    }
                    .alert(isPresented: $end) {
                        Alert(title: Text("Game Over"),
                              message: Text("Your score is \(game.score)"),
                              dismissButton: .default(Text("Close and New Game"), action: {
                            game.restart(rand: random)
                        }))
                    }
                //newgame
                //picker
            }
        }
    }
}


/*struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
      //  BoardView()
    }
}*/

