//
//  HomePageView.swift
//  DrinksOnMe
//
//  Created by Arthur De letter on 11/10/2022.
//

import SwiftUI

struct HomePageView: View {
    @StateObject private var vm = DrinkViewModel()
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading) {
                ZStack {
                    ForEach(vm.drinks, id: \.idDrink) { drink in
                        NavigationLink {
                            DrinkDetailView(drinkId: drink.idDrink)
                        } label: {
                            RandomDrinkView(drink: drink)
                        }
                    }
                }
                .onAppear(perform: fetchDataIfNeeded)
                .alert(isPresented: $vm.hasError, error: vm.errortje) {
                    Button(action: vm.fetchRandomDrink) {
                        Text("Retry")
                            .foregroundColor(Color("AccentColor"))
                    }
                }
                Spacer()
                Button(action: vm.fetchRandomDrink) {
                    Text("Random drink")
                        .font(.body)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
            .navigationTitle("Drinks on me!")
            .padding([.top, .leading, .trailing])
        }.padding(.bottom)
    }
    
    func fetchDataIfNeeded() {
        if vm.drinks.isEmpty {
            vm.fetchRandomDrink()
        }
    }
}

struct RandomDrinkView: View {
    let drink: Drink
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: drink.strDrinkThumb)) { image in
                image.resizable().aspectRatio(1/1, contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(drink.strDrink)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("CustomBlack"))
                        .multilineTextAlignment(.leading)
                    Text("Featured")
                        .fontWeight(.bold)
                        .foregroundColor(Color("PrimaryColor"))
                        .padding(.bottom, 8.0)
                }
                .padding(.all)
                Spacer()
            }
        }
        .background(Color("OffWhite"))
        .clipShape(RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius))
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 20
    }
}



struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
