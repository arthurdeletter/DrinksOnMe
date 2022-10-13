//
//  DrinksOnMeApp.swift
//  DrinksOnMe
//
//  Created by Arthur De letter on 11/10/2022.
//

import SwiftUI

@main
struct DrinksOnMeApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                HomePageView()
                    .tabItem {
                        Image(systemName:"house")
                    }
                IHaveView()
                    .tabItem {
                        Image(systemName:"dice.fill")
                    }
                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }
                CategoryView()
                    .tabItem {
                        Image(systemName: "scroll.fill")
                    }
            }
            .tint(.accentColor)
        }
    }
}
