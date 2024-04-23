//
//  FirstTabView.swift
//  LifeCycleDemo
//
//  Created by 조성빈 on 4/19/24.
//

import SwiftUI

struct FirstTabView: View {
    
    @State var title = "View One!"
    
    var body: some View {
        Text(title)
            .onAppear {
                print("onAppear triggered")
            }
            .onDisappear {
                print("onDisappear triggered")
                title = "View One, Again!!"
            }
            .task(priority: .background) {
                print("task triggered")
                title = await changeTitle()
            }
    }
    
    
    func changeTitle() async -> String {
        sleep(5)
        return "Async task complete"
    }
    
}

#Preview {
    FirstTabView()
}
