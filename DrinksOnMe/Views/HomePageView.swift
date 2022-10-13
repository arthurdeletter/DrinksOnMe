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
        VStackLayout(alignment: .leading) {
            Text("Drinks on me!")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top)
            ZStack {
                ForEach(vm.drinks, id: \.idDrink) { drink in
                    RandomDrinkView(drink: drink)
                }
            }
            .onAppear(perform: vm.fetchRandomDrinks)
            .alert(isPresented: $vm.hasError, error: vm.errortje) {
                Button(action: vm.fetchRandomDrinks) {
                    Text("Retry")
                        .foregroundColor(Color("AccentColor"))
                }
            }
            Spacer()
            Button(action: {
                
            }) {
                Text("Random cocktail")
                    .font(.body)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .padding([.leading, .bottom, .trailing])
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
                        .foregroundColor(Color.black)
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
