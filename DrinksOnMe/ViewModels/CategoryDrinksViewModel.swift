//
//  CategoryDrinksViewModel.swift
//  DrinksOnMe
//
//  Created by Arthur De letter on 15/10/2022.
//

import Foundation

final class CategoryDrinksViewModel: ObservableObject {
    @Published var drinks: [FilteredDrink] = []
    @Published var hasError = false
    @Published var errortje: CategoryDrinksError?
    @Published private(set) var isRefreshing = false
    @Published var selectedCategory = ""
    
    func fetchCategoryDrinks(_ category: String) {
        hasError = false
        isRefreshing = true
        let categoryName = category.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        selectedCategory = category
        
        let categoryDrinksUrl = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=" + categoryName!
        if let url = URL(string: categoryDrinksUrl) {
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
                            self?.errortje = CategoryDrinksError.custom(error: error)
                            self?.hasError = true
                            print(error)
                        }
                        self?.isRefreshing = false
                    }
                    
                }.resume()
        }
    }
}

extension CategoryDrinksViewModel {
    enum CategoryDrinksError: LocalizedError {
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
