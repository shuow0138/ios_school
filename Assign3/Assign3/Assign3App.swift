//
//  Assign3App.swift
//  Assign3
//
//  Created by Shuo Wang on 5/10/23.
//

import SwiftUI

@main
struct Assign3App: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(Triples())
        }
    }
}
