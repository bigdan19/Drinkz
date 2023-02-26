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
        var localIngredientsKeys: [Drink.DynamicStringKeys] = []
        var localMeasuresKeys: [Drink.DynamicStringKeys] = []
        
        
        // Creating array of Ingredient and array of Measure keys
        for key in dynamicContainer.allKeys {
            if key.stringValue.hasPrefix("strIngredient") {
                localIngredientsKeys.append(key)
            } else if key.stringValue.hasPrefix("strMeasure") {
                localMeasuresKeys.append(key)
            }
        }
        
        // Sorting ingredient keys array
        let ingredientKeysSorted = localIngredientsKeys.sorted { leftIngredient, rightIngredient in
            let leftNumber = Int(leftIngredient.stringValue.replacingOccurrences(of: "strIngredient", with: "")) ?? .max
            let rightNumber = Int(rightIngredient.stringValue.replacingOccurrences(of: "strIngredient", with: "")) ?? .max
            return leftNumber < rightNumber
        }
        
        // Sorting measure keys array
        let measuresKeysSorted = localMeasuresKeys.sorted { leftMeasure, rightMeasure in
            let leftNumber = Int(leftMeasure.stringValue.replacingOccurrences(of: "strMeasure", with: "")) ?? .max
            let rightNumber = Int(rightMeasure.stringValue.replacingOccurrences(of: "strMeasure", with: "")) ?? .max
            return leftNumber < rightNumber
        }
        
        // Going through all ingredient keys and appending array of local ingredients
        for key in ingredientKeysSorted {
            if let str = try? dynamicContainer.decode(String.self, forKey: key) {
                if key.stringValue.hasPrefix("strIngredient") {
                    localIngredients.append(str)
                }
            }
        }
        
        // Going through all measure keys and appending array of local measures
        for key in measuresKeysSorted {
            if let str = try? dynamicContainer.decode(String.self, forKey: key) {
                if key.stringValue.hasPrefix("strMeasure") {
                    localMeasures.append(str)
                }
            }
        }
        
        self.ingredients = localIngredients
        self.measures = localMeasures
    }
}
