//
//  Drink.swift
//  DrinksOnMe
//
//  Created by Arthur De letter on 12/10/2022.
//

import Foundation

struct InitialDrinks: Codable {
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
    
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    
    func getIngredients() -> Array<String> {
        var tempIngredients: [String] = []
        var ingredients: [String] = []
        tempIngredients.append(strIngredient1 ?? "")
        tempIngredients.append(strIngredient2 ?? "")
        tempIngredients.append(strIngredient3 ?? "")
        tempIngredients.append(strIngredient4 ?? "")
        tempIngredients.append(strIngredient5 ?? "")
        tempIngredients.append(strIngredient6 ?? "")
        tempIngredients.append(strIngredient7 ?? "")
        tempIngredients.append(strIngredient8 ?? "")
        tempIngredients.append(strIngredient9 ?? "")
        tempIngredients.append(strIngredient10 ?? "")
        tempIngredients.append(strIngredient11 ?? "")
        tempIngredients.append(strIngredient12 ?? "")
        tempIngredients.append(strIngredient13 ?? "")
        tempIngredients.append(strIngredient14 ?? "")
        tempIngredients.append(strIngredient15 ?? "")
        
        for ing in tempIngredients {
            if ing != "" {
                ingredients.append(ing)
            }
            break
        }
        return ingredients
    }
}
