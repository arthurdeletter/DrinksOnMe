//
//  Category.swift
//  DrinksOnMe
//
//  Created by Arthur De letter on 12/10/2022.
//

import Foundation

struct InitialCategories: Codable {
    let drinks: [Category]
}

struct Category: Codable {
    let strCategory: String
}
