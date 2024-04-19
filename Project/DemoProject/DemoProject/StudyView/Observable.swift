//
//  Observable.swift
//  DemoProject
//
//  Created by 조성빈 on 4/19/24.
//

import SwiftUI

class DemoViewModel: ObservableObject {
    @Published var userCount = 0
    @Published var currentUser = "Bins"
    
    func updateData() {
        userCount += 1
    }
}

struct Observable: View {
    // ObservedObject는 값이 변할떄 마다 '전체 뷰'를 다시 그리고, StateObject는 '필요한 부분'만 골라서 갱신하기 때문에 StateObject가 상위호환이다.
//    @ObservedObject var demoVM: DemoViewModel = DemoViewModel()
    @StateObject var demoVM: DemoViewModel = DemoViewModel()
    
    var body: some View {
        Text("\(demoVM.currentUser), you are user number \(demoVM.userCount)")
        Button(action: {
            demoVM.updateData()
        }) {
            Text("Plus!")
        }
    }
}

#Preview {
    Observable()
}
