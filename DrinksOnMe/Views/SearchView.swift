//
//  SearchView.swift
//  DrinksOnMe
//
//  Created by Arthur De letter on 12/10/2022.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @StateObject private var vm = SearchDrinkViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                if searchResults.isEmpty {
                    VStack {
                        Text("Search drink").font(.largeTitle)
                        Text("Find the recipe for your favourite drink just by searching the name.").foregroundColor(.gray).multilineTextAlignment(.center).padding(.horizontal, 50.0)
                    }
                }
                else {
                    List {
                        ForEach(searchResults, id: \.idDrink) { drink in
                            NavigationLink(destination: DrinkDetailView(drinkId: drink.idDrink)) {
                                HStack {
                                    Text(drink.name)
                                }
                            }
                        }
                    }
                }
            }.searchable(text: $searchText, prompt: "E.g. Mojito")
        }
        .padding(.bottom)
    }
    
    var searchResults: [Drink] {
        if searchText.count > 0 {
            vm.searchDrinkByName(searchText)
            return vm.results
        }
        return []
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
