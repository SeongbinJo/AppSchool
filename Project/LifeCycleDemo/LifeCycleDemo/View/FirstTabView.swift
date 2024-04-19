//
//  FirstTabView.swift
//  LifeCycleDemo
//
//  Created by 조성빈 on 4/19/24.
//

import SwiftUI

struct FirstTabView: View {
    var body: some View {
        Text("View One")
            .onAppear {
                print("onAppear triggered")
            }
            .onDisappear {
                print("onDisappear triggered")
            }
    }
}

#Preview {
    FirstTabView()
}
