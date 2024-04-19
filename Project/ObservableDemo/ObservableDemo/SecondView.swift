//
//  SecondView.swift
//  ObservableDemo
//
//  Created by 조성빈 on 4/19/24.
//

import SwiftUI

struct SecondView: View {
    
    @EnvironmentObject var timerVM: TimerViewModel
    
    var body: some View {
        VStack {
            Text("Second View")
                .font(.largeTitle)
            
            Text("Timer Count = \(timerVM.timeCount)")
                .font(.headline)
        }
    }
}

#Preview {
    SecondView()
        .environmentObject(TimerViewModel())
}
