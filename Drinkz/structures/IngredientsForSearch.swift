//
//  IngredientsForSearch.swift
//  Drinkz
//
//  Created by Daniel on 27/02/2023.
//

import Foundation

struct ListOfIngredients: Codable {
    var drinks: [Ingredient]
}

struct Ingredient: Codable {
    var strIngredient1: String
}
