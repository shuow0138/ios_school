//
//  model.swift
//  assign1
//
//  Created by Shuo Wang on 5/3/23.
//
import Foundation

enum Direction {
    case left,right,up,down
}

struct Scores: Hashable {
    var score: Int
    var time: Date
    var value: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(time)
    }
    
    init(score: Int, time: Date) {
        // self.value = self.getValue()
        self.score = score
        self.time = time
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "dd/MM/YY - HH:mm:ss "
        let stringDate = timeFormatter.string(from: time)
        let summary = "Score: \(score) \n Time: \(stringDate) \n"
        self.value = summary
        
    }
    /*
     func getValue()->String{
     let timeFormatter = DateFormatter()
     timeFormatter.dateFormat = "dd/MM/YY - HH:mm:ss "
     let stringDate = timeFormatter.string(from: time)
     return "Score: \(score) \n Time: \(stringDate) \n"
     }*/
    
    
}


struct Tile  {
    
    
    var val : Int
    var id : Int
    var row: Int    // recommended
    var col: Int    // recommended
    
    static func == (l:Tile, r:Tile) -> Bool{
        return l.val == r.val && l.id == r.id
    }
    
    
}

class Triples: ObservableObject{
    @Published var board: [[Tile?]]
    @Published var score: Int
    @Published var scores: [Scores]
    // var random: Bool
    var generator: RandomNumberGenerator
    var isDone: Bool
    
    init(){
        //  random = true
        generator = SeededGenerator(seed: UInt64(Int.random(in:1...1000)))
        board = []
        score = 6
        isDone = false
        scores = [Scores(score: 300, time: Date())]
        scores.append(Scores(score: 400, time: Date()))
            
       
        /* counter = 0
         for row in 0..<4{
         for col in 0..<4{
         board.append([])
         }
         
         }*/
        board = [[Tile(val: 1, id: 1, row: 0, col: 0), Tile(val: 0, id: 2, row: 0, col: 1), Tile(val: 0, id: 3, row: 0, col: 2), Tile(val: 1, id: 4, row: 0, col: 3)],
                 [Tile(val: 0, id: 5, row: 1, col: 0), Tile(val: 2, id: 6, row: 1, col: 1), Tile(val: 0, id: 7, row: 1, col: 2),Tile(val: 2, id: 8, row: 1, col: 3)],
                 [Tile(val: 0, id: 9, row: 2, col: 0), Tile(val: 0, id: 10, row: 2, col: 1), Tile(val: 0, id: 11, row: 2, col: 2), Tile(val: 0, id: 12, row: 2, col: 3)],
                 [Tile(val: 0, id: 13, row: 3, col: 0),Tile(val: 0, id: 14, row: 3, col: 1),Tile(val: 0, id: 15, row: 3, col: 2), Tile(val: 0, id: 16, row: 3, col: 3) ]]
        
        
        
    }
    func sortScores(score_list: [Scores]) ->  [Scores]  {
        var sortedlist = score_list
        sortedlist.sort(by: { $0.score > $1.score })
        return sortedlist
    }
    func newgame(rand : Bool) {
        
        scores.append(Scores(score: self.score, time: Date()))
        scores = sortScores(score_list: scores)
        print(scores)
        board = []
        /*for _ in 0..<4{
         board.append([0,0,0,0])
         }*/
        board = [[Tile(val: 0, id: 1, row: 0, col: 0), Tile(val: 0, id: 2, row: 0, col: 1), Tile(val: 0, id: 3, row: 0, col: 2), Tile(val: 0, id: 4, row: 0, col: 3)],
                 [Tile(val: 0, id: 5, row: 1, col: 0), Tile(val: 0, id: 6, row: 1, col: 1), Tile(val: 0, id: 7, row: 1, col: 2),Tile(val: 0, id: 8, row: 1, col: 3)],
                 [Tile(val: 0, id: 9, row: 2, col: 0), Tile(val: 0, id: 10, row: 2, col: 1), Tile(val: 0, id: 11, row: 2, col: 2), Tile(val: 0, id: 12, row: 2, col: 3)],
                 [Tile(val: 0, id: 13, row: 3, col: 0),Tile(val: 0, id: 14, row: 3, col: 1),Tile(val: 0, id: 15, row: 3, col: 2), Tile(val: 0, id: 16, row: 3, col: 3) ]]
        score = 0
        
        if rand{
            //ran
            generator = SeededGenerator(seed: UInt64(Int.random(in:1...1000)))
        }else {
            generator = SeededGenerator(seed: 14)
        }
    }
    func restart(rand : Bool){
        newgame(rand: rand)
        spawn()
        spawn()
        spawn()
        spawn()
        
    }
    // re-inits 'board', and any other state you define
    func rotate() {
        board = rotate2D(input:board)
    }                    // rotate a square 2D Int array clockwise
    
    func shift() {
        let n = board.count
        
        for i in 0..<n{
            for j in 0..<n-1{
                if (j < board[i].count-1){
                    
                    let curr = board[i][j]?.val
                    let next = board[i][j+1]?.val
                    var sum = curr ?? 0
                    sum += next ?? 0
                    
                    if(curr == 0){
                        let temp = board[i][j]
                        board[i][j] = board[i][j+1]
                        board[i][j+1] = temp
                    }
                    else if ((curr == 1 && next == 2) || (curr == 2 && next == 1)){
                        board[i][j]?.val = sum
                        board[i][j+1]?.val = 0
                        score += 3
                    }
                    else if (curr != 1 && curr != 2 && next != 1 && next != 2 && curr == next){
                        board[i][j]?.val = sum
                        board[i][j+1]?.val = 0
                        score += sum
                    }
                }
            }
            
        }
        
    }
    
    // collapse to the left
    func collapse(dir: Direction) -> Bool {
        let temp = board
        switch dir {
        case .left:
            shift()
        case .right:
            rotate(); rotate(); shift(); rotate(); rotate()
        case .up:
            rotate(); rotate(); rotate(); shift(); rotate()
        case .down:
            rotate(); shift(); rotate(); rotate(); rotate()
        }
        //return isNotFail()
        return !isSameBoard(temp: temp, board: board)
        /* if temp == board{
         return false
         }else{
         return true
         }*/
        
    }
    private func isSameBoard(temp:[[Tile?]],board:[[Tile?]]) -> Bool{
        for i in 0..<4{
            for j in 0..<4{
                if temp[i][j]?.val == board[i][j]?.val{
                    continue
                }else{
                    return false
                }
            }
        }
        return true
    }
    private func checkOpenPosi()->[[Int]]{
        var openPosi : [[Int]] = []
        let n = board.count
        for i in 0..<n{
            for j in 0..<n{
                if board[i][j]?.val == 0{
                    openPosi.append([i,j])
                }
            }
        }
        return openPosi
    }
    private func isNotFail()-> Bool{
        let l = checkOpenPosi()
        if l.count == 0{
            return false
        }else{
            return true
        }
    }
    func isGameDone()->Bool{
        return !isNotFail()
    }
    func spawn(){
        let openPosi = checkOpenPosi()
        let size = openPosi.count
        
        let newValue = Int.random(in: 1...2, using: &generator)
        let newPosi = Int.random(in: 0..<size, using: &generator)
        
        board[openPosi[newPosi][0]][openPosi[newPosi][1]]?.val = newValue
        score += newValue
        
    }
}
// class-less function that will return of any square 2D Int array rotated clockwise
public func rotate2DInts(input: [[Int]]) -> [[Int]] {
    let rotated2DInts = rotate2D(input: input)
    return rotated2DInts
}

public func rotate2D<T>(input:[[T]])->[[T]]{
    let n = input.count
    var output = Array(repeating: Array(repeating: input[0][0], count: n), count: n)
    for i in 0..<n {
        for j in 0..<n {
            output[j][n-i-1] = input[i][j]
        }
    }
    return output
}


