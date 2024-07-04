//
//  ContentView.swift
//  CoreDataApp
//
//  Created by 조성빈 on 7/2/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    let coreDM: CoreDataManager
    
    @State var petName = ""
    @State var petBreed = ""
    @State var petArray = [Animal]()
    
    var body: some View {
        VStack {
            TextField("Enter pet name", text: $petName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Enter pet breed", text: $petBreed)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Save") {
                coreDM.savePet(name: petName, breed: petBreed)
                displayPets()
                petName = ""
                petBreed = ""
            }
            
            List {
                ForEach(petArray, id: \.self) { pet in
                    VStack {
                        Text(pet.name ?? "")
                        Text(pet.breed ?? "")
                    }
                }
                .onDelete(perform: { indexSet in
                    indexSet.forEach { index in
                        let pet = petArray[index]
                        coreDM.deletePet(animal: pet)
                        displayPets()
                    }
                })
            }
        }
        .padding()
        .onAppear {
            displayPets()
        }

    }

    func displayPets() {
        petArray = coreDM.getAllPets()
    }
    
}

#Preview {
    ContentView(coreDM: CoreDataManager())
}
