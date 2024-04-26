//
//  ContentView.swift
//  FocusAndSubmit
//
//  Created by 조성빈 on 4/26/24.
//

import SwiftUI


struct ContentView: View {
    enum AddressField {
        case streetName
        case city
        case state
        case zipCode
    }
    
    @State private var streetName = ""
    @State private var city = ""
    @State private var state = ""
    @State private var zipCode = ""
    
    @FocusState private var currentFocus: AddressField?
    
    var body: some View {
        VStack {
            TextField("Address", text: $streetName)
                .focused($currentFocus, equals: .streetName)
                .submitLabel(.next)
            TextField("city", text: $city)
                .focused($currentFocus, equals: .city)
                .submitLabel(.next)
            TextField("state", text: $state)
                .focused($currentFocus, equals: .state)
                .submitLabel(.next)
            TextField("zipCode", text: $zipCode)
                .focused($currentFocus, equals: .zipCode)
                .submitLabel(.next)
        }
        .padding()
        .onAppear {
            currentFocus = .streetName
        }
        .onSubmit {
            switch currentFocus {
            case .streetName:
                currentFocus = .city
            case .city:
                currentFocus = .state
            case .state:
                currentFocus = .zipCode
            case .zipCode:
                currentFocus = .streetName
            default:
                print("Done!")
            }
        }
    }
}

#Preview {
    ContentView()
}
