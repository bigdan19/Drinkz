//
//  IngredientsForSearch.swift
//  Drinkz
//
//  Created by Daniel on 27/02/2023.
//

import Foundation

struct listOfIngredients: Codable {
    var drinks: [ingredient]
}

struct ingredient: Codable {
    var strIngredient1: String
}
