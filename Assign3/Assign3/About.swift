//
//  About.swift
//  assign1
//
//  Created by Shuo Wang on 5/7/23.
//

import SwiftUI

struct About: View {
    @State private var isAnimating = false
    var body: some View {
        Text("Have Fun")

                   .font(.largeTitle)
                   .foregroundColor(isAnimating ? .green : .purple)
                   .scaleEffect(isAnimating ? 1.5 : 1)
                   .rotationEffect(isAnimating ? .degrees(360) : .degrees(0))
                   
                   //.animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true))
                   .onAppear() {
                       withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)){
                           self.isAnimating.toggle()
                       }
                       
                   }
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        About()
    }
}
