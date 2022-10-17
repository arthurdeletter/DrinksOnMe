//
//  FilteredDrink.swift
//  DrinksOnMe
//
//  Created by Arthur De letter on 15/10/2022.
//

import Foundation

struct InitialFilteredDrink: Codable {
    let drinks: [FilteredDrink]
}

struct FilteredDrink: Codable {
    let idDrink: String
    let strDrink: String
    let strDrinkThumb: String
}
