//
//  AsyncAwait.swift
//  DemoProject
//
//  Created by 조성빈 on 4/19/24.
//

import SwiftUI

struct AsyncAwait: View {
    
    func doSomething() {
        print("Start : \(Date())")
        Task(priority: .background) {
            async let result: () = takesTooLong()
            print("\(await result)")
        }
        print("End : \(Date())")
    }
    
    func takesTooLong() async {
        sleep(5)
        print("Async task completed at \(Date())")
    }
    
    var body: some View {
        VStack {
            Button(action: {
                 doSomething()
            }) {
                Text("Do Somthing")
            }
        }
    }
}

#Preview {
    AsyncAwait()
}
