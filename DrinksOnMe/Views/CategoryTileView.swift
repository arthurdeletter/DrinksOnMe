//
//  CategoryTileView.swift
//  DrinksOnMe
//
//  Created by Arthur De letter on 12/10/2022.
//

import SwiftUI

struct CategoryTileView: View {
    let category: Category
//    let bgColor: Int
//    let colors = [Color.red, Color.blue, Color.green, Color.yellow, Color.brown, Color.gray, Color.cyan, Color.orange, Color.purple]
    var body: some View {
        NavigationLink(destination: ResultListView()) {
            ZStack {
                RoundedRectangle(cornerRadius: 20.0)
                Text(category.strCategory)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
        }
    }
}

struct CategoryTileView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryTileView(category: .init(strCategory: "Cocktails"))
    }
}
