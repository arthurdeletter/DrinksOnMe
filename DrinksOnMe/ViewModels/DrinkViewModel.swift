//
//  DrinkViewModel.swift
//  DrinksOnMe
//
//  Created by Arthur De letter on 12/10/2022.
//

import Foundation

final class DrinkViewModel: ObservableObject {
    @Published var drinks: [Drink] = []
    @Published var hasError = false
    @Published var errortje: DrinkError?
    @Published private(set) var isRefreshing = false
    
    func fetchRandomDrink() {
        let randomDrinkUrl = "https://www.thecocktaildb.com/api/json/v1/1/random.php"
        if let url = URL(string: randomDrinkUrl) {
            URLSession
                .shared
                .dataTask(with: url) { [weak self] data, response, error in
                    
                    DispatchQueue.main.async {
                            do {
                                if let data = data {
                                    let jsonData = try JSONDecoder().decode(InitialDrinks.self, from: data)
                                    self?.drinks = jsonData.drinks
                                }
                            } catch(let error) {
                                self?.errortje = DrinkError.custom(error: error)
                                self?.hasError = true
                                print(error)
                            }
                        self?.isRefreshing = false
                    }
                    
                }.resume()
        }
    }
    
    func fetchDrinkById(_ id: String) {
        let randomDrinkUrl = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=" + id
        if let url = URL(string: randomDrinkUrl) {
            URLSession
                .shared
                .dataTask(with: url) { [weak self] data, response, error in
                    
                    DispatchQueue.main.async {
                            do {
                                if let data = data {
                                    let jsonData = try JSONDecoder().decode(InitialDrinks.self, from: data)
                                    self?.drinks = jsonData.drinks
                                }
                            } catch(let error) {
                                self?.errortje = DrinkError.custom(error: error)
                                self?.hasError = true
                                print(error)
                            }
                        self?.isRefreshing = false
                    }
                    
                }.resume()
        }
    }
    
}

extension DrinkViewModel {
    enum DrinkError: LocalizedError {
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
