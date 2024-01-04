//
//  TileView.swift
//  assign1
//
//  Created by Shuo Wang on 5/7/23.
//
import SwiftUI
import Foundation

struct TileView: View {
    @Environment(\.verticalSizeClass) var orientation: UserInterfaceSizeClass?
    var tile = Tile(val: 0, id: 0, row: 0, col: 0)
    
    init(tile: Tile) {
        self.tile = tile
    }
    
    var body: some View {
        let color = Color(red: Double(tile.val) / 3, green: 0.5, blue: 1.0)
        Text(tile.val.description)
            .padding()
            .font(tile.val < 12 ? .title : tile.val < 23 ? .title : .title3)
            .frame( width: orientation == .regular ?  65 : 60, height: orientation == .regular ? 80 : 49)
            .cornerRadius(5).foregroundColor(.white)
           // .animation(.easeInOut(duration: 0.4))
            .background(color)
    }
}
