//
//  CategoryResultView.swift
//  DrinksOnMe
//
//  Created by Arthur De letter on 12/10/2022.
//

import SwiftUI

struct CategoryResultView: View {
    let categoryTitle: String
    @StateObject private var vm = CategoryDrinksViewModel()
    
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
                    vm.fetchCategoryDrinks(categoryTitle)
                }) {
                    Text("Retry")
                        .foregroundColor(Color("AccentColor"))
                }
            }
            .padding(.horizontal)
            .navigationTitle(categoryTitle)
        }
        .padding(.bottom)
    }
    
    func fetchDataIfNeeded() {
        if vm.selectedCategory != categoryTitle {
            vm.fetchCategoryDrinks(categoryTitle)
        }
    }
}

struct ResultListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryResultView(categoryTitle: "Cocktail")
    }
}
