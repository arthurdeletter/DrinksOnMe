//
//  DrinkDetailView.swift
//  DrinksOnMe
//
//  Created by Arthur De letter on 15/10/2022.
//

import SwiftUI

struct DrinkDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var vm = DrinkViewModel()
    let drinkId: String?
    var drink: [Drink]?
    
    var btnBack : some View { Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            }) {
                ZStack {
                    Image(systemName: "xmark")
                        .aspectRatio(1/1, contentMode: .fit)
                        .padding(.all, 6)
                }
                .foregroundColor(.white)
                .background(Color.accentColor)
                .cornerRadius(8.0)
            }
        }
    
    var body: some View {
        ZStack {
            ForEach(vm.drinks, id: \.idDrink) { drink in
                DetailView(drink: drink).frame(maxWidth: .infinity)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(trailing: btnBack)
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
                AsyncImage(url: URL(string: drink.thumb)) { image in
                    image
                        .resizable()
                        .aspectRatio(1/1, contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .ignoresSafeArea()
                } placeholder: {
                    ProgressView()
                }
            }
            GeometryReader(content: { geometry in
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0.0) {
                        VStack(alignment: .leading) {
                            Text(drink.name).font(.largeTitle).fontWeight(.bold)
                            HStack(spacing: 4) {
                                Text(drink.category)
                                Text("·").font(.largeTitle)
                                Text(drink.alcoholic)
                            }.foregroundColor(.accentColor).fontWeight(.medium)
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Ingredients").font(.title).fontWeight(.medium).padding(.bottom, 1.0)
                            VStack(alignment: .leading) {
                                ForEach(drink.ingredients, id: \.self) { ingredient in
                                    if (ingredient != nil) {
                                        Text("👉 " + ingredient!).foregroundColor(.gray)
                                    }
                                }
                            }
                        }
                        .padding(.top)
                        
                        VStack(alignment: .leading) {
                            Text("How to prepare").font(.title).fontWeight(.medium).padding(.bottom, 1.0)
                            HStack {
                                Text(drink.instructions).multilineTextAlignment(.leading).foregroundColor(.gray)
                                Spacer()
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 20)
                    .foregroundColor(Color("CustomBlack"))
                }
                .frame(maxWidth: .infinity, minHeight: geometry.size.height + 70)
                .padding([.top, .leading, .trailing])
                .background(Color("CustomWhite"))
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .offset(y: -100)
            })
        }.frame(maxWidth: .infinity)
    }
}

struct DrinkDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DrinkDetailView(drinkId: "0")
    }
}
