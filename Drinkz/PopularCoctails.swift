//
//  PopularCoctails.swift
//  Drinkz
//
//  Created by Daniel on 17/02/2023.
//

import Foundation


struct listOfPopularDrinks: Codable {
    var drinks: [Drink]
}

struct Drink: Codable {
    let name: String
    let instructions: String
    let imageUrl: String?
    let category: String
    let glass: String
    let alcoholic: String
    
    //arrays for ingredients and measeure
    let ingredients: [String]
    let measures: [String]
    //custom special coding key which stands for any string
    //e.g. instead of key ingredient1 dynamic string stands for "any string key"
    struct DynamicStringKeys: CodingKey {
        var stringValue: String
        var intValue: Int?
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        init?(intValue: Int) {
            self.stringValue = "\(intValue)";
            self.intValue = intValue
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case name = "strDrink"
        case instructions = "strInstructions"
        case imageUrl = "strDrinkThumb"
        case category = "strCategory"
        case glass = "strGlass"
        case alcoholic = "strAlcoholic"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        instructions = try container.decode(String.self, forKey: .instructions)
        imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
        category = try container.decode(String.self, forKey: .category)
        glass = try container.decode(String.self, forKey: .glass)
        alcoholic = try container.decode(String.self, forKey: .alcoholic)
        //create container will all keys in the JSON
        let dynamicContainer = try decoder.container(keyedBy: DynamicStringKeys.self)
        var localIngredients: [String] = []
        var localMeasures: [String] = []
        //iterate over dynamic keys
        for key in dynamicContainer.allKeys {
            if let str = try? dynamicContainer.decode(String.self, forKey: key) {
                /**
                 check if key starts with strIngredient or strMeasure and add value to the corresponsign array
                 */
                if key.stringValue.hasPrefix("strIngredient") {
                    localIngredients.append(str)
                } else if key.stringValue.hasPrefix("strMeasure") {
                    localMeasures.append(str)
                }
            }
        }
        self.ingredients = localIngredients
        self.measures = localMeasures
    }
}
