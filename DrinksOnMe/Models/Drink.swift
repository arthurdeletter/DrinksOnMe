//
//  Drink.swift
//  DrinksOnMe
//
//  Created by Arthur De letter on 12/10/2022.
//

import Foundation

struct Initial: Codable {
    let drinks: [Drink]
}

struct Drink: Codable {
    let idDrink: String
    let strDrink: String
    var strTags: String?
    let strCategory: String
    let strAlcoholic: String
    let strInstructions: String
    let strDrinkThumb: String
}
