//
//  HomePageView.swift
//  DrinksOnMe
//
//  Created by Arthur De letter on 11/10/2022.
//

import SwiftUI

struct HomePageView: View {
    @StateObject private var vm = DrinkViewModel()
    @Environment(\.horizontalSizeClass) var widthSizeClass
    @Environment(\.verticalSizeClass) var heightSizeClass
    
    var body: some View {
        NavigationView {
            if heightSizeClass == .regular {
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
                    VStack(alignment: .center) {
                        Image(systemName: "dice.fill")
                            .resizable()
                            .aspectRatio(1/1, contentMode: .fit)
                            .frame(width: 40, height: 40, alignment: .center)
                            .padding(.all, 20)
                            .background(Color("OffWhite"))
                            .clipShape(Circle())
                            .onTapGesture(perform: vm.fetchRandomDrink)
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.accentColor)
                    .padding(.all)
                }
                .navigationTitle("Drinks on me!")
                .padding([.top, .leading, .trailing])
            } else {
                HStack {
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
                    VStack(alignment: .center) {
                        Image(systemName: "dice.fill")
                            .resizable()
                            .aspectRatio(1/1, contentMode: .fit)
                            .frame(width: 40, height: 40, alignment: .center)
                            .padding(.all, 20)
                            .background(Color("OffWhite"))
                            .clipShape(Circle())
                            .onTapGesture(perform: vm.fetchRandomDrink)
                    }
                    .foregroundColor(.accentColor)
                    .padding(.all)
                }
                .navigationTitle("Drinks on me!")
                .padding([.top, .leading, .trailing])
            }
        }.navigationViewStyle(StackNavigationViewStyle())
            .padding(.bottom)
    }
    
    func fetchDataIfNeeded() {
        if vm.drinks.isEmpty {
            vm.fetchRandomDrink()
        }
    }
}

struct RandomDrinkView: View {
    @Environment(\.horizontalSizeClass) var widthSizeClass
    @Environment(\.verticalSizeClass) var heightSizeClass
    let drink: Drink
    
    var body: some View {
        if heightSizeClass == .regular {
            VStack {
                AsyncImage(url: URL(string: drink.thumb)) { image in
                    image.resizable().aspectRatio(1/1, contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(drink.name)
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
        else {
            HStack {
                AsyncImage(url: URL(string: drink.thumb)) { image in
                    image.resizable().aspectRatio(1/1, contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(drink.name)
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
