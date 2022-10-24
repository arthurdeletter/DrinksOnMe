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
                SearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                    }
                IHaveView()
                    .tabItem {
                        Image(systemName:"list.bullet.clipboard")
                    }
                CategoryView()
                    .tabItem {
                        Image(systemName: "safari")
                    }
            }
            .tint(.accentColor)
        }
    }
}
