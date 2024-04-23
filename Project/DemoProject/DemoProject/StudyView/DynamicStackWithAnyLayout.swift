//
//  UsingPicker.swift
//  DemoProject
//
//  Created by 조성빈 on 4/18/24.
//

import SwiftUI



struct UsingPicker: View {
    
    @State var myLayout: AnyLayout = AnyLayout(VStackLayout())
    
    var body: some View {
        VStack {
            myLayout {
                Image(systemName: "house.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Image(systemName: "house.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            HStack {
                Button(action: {
                    myLayout = AnyLayout(HStackLayout())
                }) {
                    Text("Hstack")
                }
                Button(action: {
                    myLayout = AnyLayout(VStackLayout())
                }) {
                    Text("Vstack")
                }
            }
        }
    }
}

#Preview {
    UsingPicker()
}
