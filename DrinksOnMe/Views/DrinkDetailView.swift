//
//  DrinkDetailView.swift
//  DrinksOnMe
//
//  Created by Arthur De letter on 15/10/2022.
//

import SwiftUI

struct DrinkDetailView: View {
    @StateObject private var vm = DrinkViewModel()
    let drinkId: String?
    var drink: [Drink]?
    
    var body: some View {
        ZStack {
            ForEach(vm.drinks, id: \.idDrink) { drink in
                DetailView(drink: drink)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            if drinkId != nil {
                vm.fetchDrinkById(drinkId!)
            } else {
                vm.fetchRandomDrink()
            }
        })
        .alert(isPresented: $vm.hasError, error: vm.errortje) {
            Button(action: {
                if drinkId != nil {
                    vm.fetchDrinkById(drinkId!)
                } else {
                    vm.fetchRandomDrink()
                }
            }) {
                Text("Retry")
                    .foregroundColor(Color("AccentColor"))
            }
        }
    }
}

struct DetailView: View {
    let drink: Drink
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack {
                AsyncImage(url: URL(string: drink.strDrinkThumb)) { image in
                    image
                        .resizable()
                        .aspectRatio(1/1, contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .ignoresSafeArea()
                } placeholder: {
                    ProgressView()
                }
            }
            ScrollView {
                VStack(alignment: .leading, spacing: 0.0) {
                    VStack(alignment: .leading) {
                        Text(drink.strDrink).font(.largeTitle).fontWeight(.bold)
                        HStack(spacing: 4) {
                            Text(drink.strCategory)
                            Text("·").font(.largeTitle)
                            Text(drink.strAlcoholic)
                        }.foregroundColor(.accentColor).fontWeight(.medium)
                    }
                    VStack(alignment: .leading) {
                        Text("Ingredients").font(.title).fontWeight(.medium).padding(.bottom, 1.0)
                        VStack(alignment: .leading) {
                            ForEach(drink.getIngredients(), id: \.self) { ingredient in
                                Text("- " + ingredient).foregroundColor(.gray)
                            }
                        }
                    }
                    .padding(.top)
                    VStack(alignment: .leading) {
                        Text("How to prepare").font(.title).fontWeight(.medium).padding(.bottom, 1.0)
                        Text(drink.strInstructions).foregroundColor(.gray)
                    }
                    .padding(.top)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 20)
            }
            .frame(maxWidth: .infinity)
            .padding([.top, .leading, .trailing])
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            .offset(y: -100)
        }.frame(maxWidth: .infinity)
    }
}

struct DrinkDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DrinkDetailView(drinkId: "0")
    }
}
