//
//  ContentView.swift
//  SearchList
//
//  Created by 조성빈 on 4/24/24.
//

import SwiftUI


struct ContentView: View {
    enum FruitSearchScope: Hashable {
        case all
        case food(Food.Category)
    }
    
    @State var searchText = ""
    @State var scope: FruitSearchScope = .all
    
    let food: [Food] = Food.sampleFood
    
    var searchResults: [Food] {
        var food: [Food] = self.food
        if case let .food(category) = scope {
            food = food.filter{ $0.category == category }
        }
        if !searchText.isEmpty {
            food = food.filter{ $0.name.lowercased().contains(searchText.lowercased()) }
        }
        return food
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults, id: \.self) { result in
                    LabeledContent(result.name) {
                        Text(result.category.rawValue)
                    }
                }
            }
        }
        .searchable(text: $searchText, prompt: "Search for a food")
        .searchScopes($scope, activation: .onSearchPresentation) {
            Text("All").tag(FruitSearchScope.all)
            Text("Fruit").tag(FruitSearchScope.food(.fruit))
            Text("Meat").tag(FruitSearchScope.food(.meat))
            Text("Vegetable").tag(FruitSearchScope.food(.vegetable))
        }
    }
}

#Preview {
    ContentView()
}
