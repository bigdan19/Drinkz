//
//  ListOfCoctailsUsingIngredient.swift
//  Drinkz
//
//  Created by Daniel on 27/02/2023.
//

import Foundation

struct ListOfCoctails: Codable {
    var drinks: [Coctail]
}

struct Coctail: Codable {
    var strDrink: String
    var strDrinkThumb: String?
    var idDrink: String
}
