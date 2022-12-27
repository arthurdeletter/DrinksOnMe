//
//  CategoryView.swift
//  DrinksOnMe
//
//  Created by Arthur De letter on 12/10/2022.
//

import SwiftUI

struct CategoryView: View {
    
    @StateObject private var vm = CategoryViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                if vm.isRefreshing {
                    ProgressView()
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 140), spacing: 16)], spacing: 16) {
                            ForEach(vm.categories, id: \.strCategory) { cat in
                                CategoryTileView(category: cat)
                                    .aspectRatio(1/1, contentMode: .fit)
                            }
                        }
                    }
                    .padding([.top, .leading, .trailing])
                    .navigationTitle("Discover")
                }
            }
            .onAppear(perform: fetchDataIfNeeded)
            .alert(isPresented: $vm.hasError, error: vm.errortje) {
                Button(action: vm.fetchDrinkCategories) {
                    Text("Retry")
                        .foregroundColor(Color("AccentColor"))
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
        .padding(.bottom)
    }
    
    func fetchDataIfNeeded() {
        if vm.categories.isEmpty {
            vm.fetchDrinkCategories()
        }
    }
    
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
