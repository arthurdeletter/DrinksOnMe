//
//  IHaveView.swift
//  DrinksOnMe
//
//  Created by Arthur De letter on 12/10/2022.
//

import SwiftUI

struct IHaveView: View {
    @State private var searchText = ""
    @StateObject private var vm = IngredientsViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                if vm.isRefreshing {
                    ProgressView()
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))], spacing: 26) {
                            ForEach(searchResults, id: \.strIngredient1) { ingredient in
                                NavigationLink {
                                    IngredientResultView(ingredientTitle: ingredient.strIngredient1)
                                } label: {
                                    IngredientTileView(ingredient: ingredient)
                                        .aspectRatio(1/1, contentMode: .fit)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding([.top, .leading, .trailing])
                }
            }
            .onAppear(perform: fetchDataIfNeeded)
            .alert(isPresented: $vm.hasError, error: vm.errortje) {
                Button(action: vm.fetchIngredients) {
                    Text("Retry")
                        .foregroundColor(Color("AccentColor"))
                }
            }
        }
        .searchable(text: $searchText, prompt: "E.g. Gin")
        .padding(.bottom)
    }
    
    func fetchDataIfNeeded() {
        if vm.ingredients.isEmpty {
            vm.fetchIngredients()
        }
    }
    
    var searchResults: [Ingredient] {
        if searchText.isEmpty {
            return vm.ingredients
        }
        return vm.ingredients.filter{ $0.strIngredient1.contains(searchText) }
    }
}

struct IngredientTileView: View {
    let ingredient: Ingredient
    let url = "https://www.thecocktaildb.com/images/ingredients/"
    let size = "-Small"
    let ext = ".png"
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: createImage(name: ingredient.strIngredient1))) { image in
                image
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)
            
            Text(ingredient.strIngredient1).fontWeight(.bold).foregroundColor(Color("CustomBlack"))
        }
    }
    
    func createImage(name: String) -> String {
        let ingredientName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return url + (ingredientName!) + size + ext
    }
}

struct IHaveView_Previews: PreviewProvider {
    static var previews: some View {
        IHaveView()
    }
}
