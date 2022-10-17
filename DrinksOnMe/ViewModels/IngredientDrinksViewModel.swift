//
//  IngredientDrinksViewModel.swift
//  DrinksOnMe
//
//  Created by Arthur De letter on 15/10/2022.
//

import Foundation

final class IngredientDrinksViewModel: ObservableObject {
    @Published var drinks: [FilteredDrink] = []
    @Published var hasError = false
    @Published var errortje: IngredientDrinksError?
    @Published private(set) var isRefreshing = false
    @Published var selectedIngredient = ""
    
    func fetchIngredientDrinks(_ ingredient: String) {
        hasError = false
        isRefreshing = true
        var ingredientName = ingredient
        selectedIngredient = ingredient
        
        if ingredient.rangeOfCharacter(from: .whitespaces) != nil {
            ingredientName = ingredient.replacingOccurrences(of: " ", with: "_")
        }
        
        let ingredientDrinksUrl = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=" + ingredientName
        if let url = URL(string: ingredientDrinksUrl) {
            URLSession
                .shared
                .dataTask(with: url) { [weak self] data, response, error in
                    
                    DispatchQueue.main.async {
                            
                        do {
                            if let data = data {
                                let jsonData = try JSONDecoder().decode(InitialFilteredDrink.self, from: data)
                                self?.drinks = jsonData.drinks
                            }
                        } catch (let error) {
                            self?.errortje = IngredientDrinksError.custom(error: error)
                            self?.hasError = true
                            print(error)
                        }
                        self?.isRefreshing = false
                    }
                    
                }.resume()
        }
    }
}

extension IngredientDrinksViewModel {
    enum IngredientDrinksError: LocalizedError {
        case custom(error: Error)
        case failedToDecode
        
        var errorDescription: String? {
            switch self {
            case .failedToDecode:
                return "Failed to decode response"
            case .custom(let error):
                return error.localizedDescription
            }
        }
    }
}
