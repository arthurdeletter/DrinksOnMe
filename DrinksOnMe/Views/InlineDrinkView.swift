//
//  InlineDrinkView.swift
//  DrinksOnMe
//
//  Created by Arthur De letter on 15/10/2022.
//

import SwiftUI

struct InlineDrinkView: View {
    let drink: FilteredDrink?
    
    var body: some View {
        NavigationLink {
            DrinkDetailView(drinkId: drink?.idDrink)
        } label: {
            HStack(spacing: 8) {
                AsyncImage(url: URL(string: drink!.strDrinkThumb)) { image in
                    image
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0))
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 100, height: 100)
                Text(drink!.strDrink).font(.title2).fontWeight(.medium).foregroundColor(Color("CustomBlack")).multilineTextAlignment(.leading)
                Spacer()
                Text(Image(systemName: "chevron.right"))
            }
        }
    }
}

struct InlineDrinkView_Previews: PreviewProvider {
    static var previews: some View {
        InlineDrinkView(drink: nil)
    }
}
