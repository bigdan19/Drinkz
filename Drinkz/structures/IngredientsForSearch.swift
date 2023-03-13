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

struct Ingredients: Codable {
    var ingredients: [Item]
}

struct Item: Codable {
    var idIngredient: String
    var strIngredient: String
    var strDescription: String?
    var strType: String?
    var strAlcohol: String?
}
