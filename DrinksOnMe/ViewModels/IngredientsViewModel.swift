//
//  IngredientsViewModel.swift
//  DrinksOnMe
//
//  Created by Arthur De letter on 15/10/2022.
//

import Foundation

final class IngredientsViewModel: ObservableObject {
    @Published var ingredients: [Ingredient] = []
    @Published var hasError = false
    @Published var errortje: IngredientError?
    @Published private(set) var isRefreshing = false
    
    func fetchIngredients() {
        hasError = false
        isRefreshing = true
        
        let ingredientsUrl = "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list"
        if let url = URL(string: ingredientsUrl) {
            URLSession
                .shared
                .dataTask(with: url) { [weak self] data, response, error in
                    
                    DispatchQueue.main.async {
                            
                        do {
                            if let data = data {
                                let jsonData = try JSONDecoder().decode(InitialIngredients.self, from: data)
                                self?.ingredients = jsonData.drinks
                            }
                        } catch (let error) {
                            self?.errortje = IngredientError.custom(error: error)
                            self?.hasError = true
                            print(error)
                        }
                        self?.isRefreshing = false
                    }
                    
                }.resume()
        }
    }
}

extension IngredientsViewModel {
    enum IngredientError: LocalizedError {
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
