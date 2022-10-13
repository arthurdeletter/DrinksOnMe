//
//  ResultListView.swift
//  DrinksOnMe
//
//  Created by Arthur De letter on 12/10/2022.
//

import SwiftUI

struct ResultListView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Cocktails")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .padding(.top)
                ScrollView {
                    List {
                        Text("Uno")
                        Text("Dos")
                        Text("Tres")
                    }
                }
            }
        }
        .padding([.leading, .bottom, .trailing])
    }
}

struct ResultListView_Previews: PreviewProvider {
    static var previews: some View {
        ResultListView()
    }
}
