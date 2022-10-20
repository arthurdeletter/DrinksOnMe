//
//  Drink.swift
//  DrinksOnMe
//
//  Created by Arthur De letter on 12/10/2022.
//

import Foundation

struct InitialDrinks: Decodable {
    let drinks: [Drink]
}

struct Drink {
    let idDrink: String
    let name: String
    var tags: String?
    let category: String
    let alcoholic: String
    let instructions: String
    let thumb: String
    var ingredients: [String?] = []
    
    enum CodingKeys: String, CodingKey {
        case idDrink
        case name = "strDrink"
        case tags = "strTags"
        case category = "strCategory"
        case alcoholic = "strAlcoholic"
        case instructions = "strInstructions"
        case thumb = "strDrinkThumb"
    }
    
    enum DrinkIngredientKeys: String, CodingKey {
        case strIngredient1
        case strIngredient2
        case strIngredient3
        case strIngredient4
        case strIngredient5
        case strIngredient6
        case strIngredient7
        case strIngredient8
        case strIngredient9
        case strIngredient10
        case strIngredient11
        case strIngredient12
        case strIngredient13
        case strIngredient14
        case strIngredient15
    }
}

extension Drink: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        idDrink = try values.decode(String.self, forKey: .idDrink)
        name = try values.decode(String.self, forKey: .name)
        tags = try values.decode(String?.self, forKey: .tags)
        category = try values.decode(String.self, forKey: .category)
        alcoholic = try values.decode(String.self, forKey: .alcoholic)
        instructions = try values.decode(String.self, forKey: .instructions)
        thumb = try values.decode(String.self, forKey: .thumb)
        
        let ings = try decoder.container(keyedBy: DrinkIngredientKeys.self)
        
        let options: [DrinkIngredientKeys] = [.strIngredient1, .strIngredient2, .strIngredient3, .strIngredient4, .strIngredient5, .strIngredient6, .strIngredient7, .strIngredient8, .strIngredient9, .strIngredient10, .strIngredient11, .strIngredient12, .strIngredient13, .strIngredient14, .strIngredient15]
        var current: String? = try ings.decode(String?.self, forKey: options[0])
        var counter = 0
        
        while (current != nil) {
            current = try ings.decode(String?.self, forKey: options[counter])
            ingredients.append(current)
            counter+=1
            
        }
    }
}
