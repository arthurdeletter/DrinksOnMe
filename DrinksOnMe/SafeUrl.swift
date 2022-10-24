//
//  SafeUrl.swift
//  DrinksOnMe
//
//  Created by Arthur De letter on 24/10/2022.
//

import Foundation

public extension String {
    var safeForUrl: String? {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}
