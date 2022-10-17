//
//  Ingredient.swift
//  DrinksOnMe
//
//  Created by Arthur De letter on 15/10/2022.
//

import Foundation

struct InitialIngredients: Codable {
    let drinks: [Ingredient]
}

struct Ingredient: Codable {
    let strIngredient1: String
}
