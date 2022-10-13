//
//  IHaveView.swift
//  DrinksOnMe
//
//  Created by Arthur De letter on 12/10/2022.
//

import SwiftUI

struct IHaveView: View {
    @State private var searchText = ""
    var body: some View {
        NavigationView {
            Text("Searching for \(searchText)")
                .searchable(text: $searchText, prompt: "Search ingredient")
                .navigationTitle("I have...")
        }
        .padding(.bottom)
    }
}

struct IHaveView_Previews: PreviewProvider {
    static var previews: some View {
        IHaveView()
    }
}
