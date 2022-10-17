//
//  IngredientResultView.swift
//  DrinksOnMe
//
//  Created by Arthur De letter on 15/10/2022.
//

import SwiftUI

struct IngredientResultView: View {
    let ingredientTitle: String
    @StateObject private var vm = IngredientDrinksViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                if vm.isRefreshing {
                    ProgressView()
                } else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 8.0) {
                            ForEach(vm.drinks, id: \.idDrink) { drink in
                                InlineDrinkView(drink: drink)
                            }
                        }
                    }
                    .padding(.top)
                }
            }
            .onAppear(perform: fetchDataIfNeeded)
            .alert(isPresented: $vm.hasError, error: vm.errortje) {
                Button(action: {
                    vm.fetchIngredientDrinks(ingredientTitle)
                }) {
                    Text("Retry")
                        .foregroundColor(Color("AccentColor"))
                }
            }
            .padding(.horizontal)
            .navigationTitle(ingredientTitle)
        }
        .padding(.bottom)
    }
    
    func fetchDataIfNeeded() {
        if vm.selectedIngredient != ingredientTitle {
            vm.fetchIngredientDrinks(ingredientTitle)
        }
    }
}

struct IngredientResultView_Previews: PreviewProvider {
    static var previews: some View {
        IngredientResultView(ingredientTitle: "Gin")
    }
}
