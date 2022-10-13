//
//  CategoryViewModel.swift
//  DrinksOnMe
//
//  Created by Arthur De letter on 12/10/2022.
//

import Foundation

final class CategoryViewModel: ObservableObject {
    @Published var categories: [Category] = []
    @Published var hasError = false
    @Published var errortje: CategoryError?
    @Published private(set) var isRefreshing = false
    
    func fetchDrinkCategories() {
        hasError = false
        isRefreshing = true
        
        let categoriesUrl = "https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list"
        if let url = URL(string: categoriesUrl) {
            URLSession
                .shared
                .dataTask(with: url) { [weak self] data, response, error in
                    
                    DispatchQueue.main.async {
                            
                        do {
                            if let data = data {
                                let jsonData = try JSONDecoder().decode(InitialCategories.self, from: data)
                                self?.categories = jsonData.drinks
                            }
                        } catch (let error) {
                            self?.errortje = CategoryError.custom(error: error)
                            self?.hasError = true
                            print(error)
                        }
                        self?.isRefreshing = false
                    }
                    
                }.resume()
        }
    }
}

extension CategoryViewModel {
    enum CategoryError: LocalizedError {
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
