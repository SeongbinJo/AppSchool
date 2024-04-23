//
//  ContentView.swift
//  ObservableDemo
//
//  Created by 조성빈 on 4/19/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var timerVM: TimerViewModel = TimerViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Timer count = \(timerVM.timeCount)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                Button(action: {
                    timerVM.resetCount()
                }) {
                    Text("Reset Count Button")
                }
                NavigationLink(destination: SecondView()) {
                    Text("Next Screen")
                }
                .padding()
            }
        }
        .environmentObject(timerVM)
    }
    
}

#Preview {
    ContentView()
}
