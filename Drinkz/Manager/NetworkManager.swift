//
//  NetworkManager.swift
//  Drinkz
//
//  Created by Daniel on 22/03/2023.
//


import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    // loading array of drinks from url
    func loadDrinks(urlString: String, withCompletion completion: @escaping([Drink]?) -> Void){
        print(urlString)
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async { completion(nil) }
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, _, _) -> Void in
            guard let data = data else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            let wrapper = try? JSONDecoder().decode(ListOfPopularDrinks.self, from: data)
            DispatchQueue.main.async { completion(wrapper?.drinks) }
        }
        task.resume()
    }
    
    // loading array of ingredients from url
    func loadListOfIngredients(urlString: String, withCompletion completion: @escaping([Ingredient]?) -> Void) {
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async { completion(nil) }
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data,_ , _) -> Void in
            guard let data = data else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            let wrapper = try? JSONDecoder().decode(ListOfIngredients.self, from: data)
            DispatchQueue.main.async { completion(wrapper?.drinks) }
        }
        task.resume()
    }
    
    // loading array of drinks from custom custom structure
    func loadListOfCoctailsFromIngredients(urlString: String, withCompletion completion: @escaping([Coctail]?) -> Void) {
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async { completion(nil) }
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data,_ ,_ ) -> Void in
            guard let data = data else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            let wrapper = try? JSONDecoder().decode(ListOfCoctails.self, from: data)
            DispatchQueue.main.async { completion(wrapper?.drinks) }
        }
        task.resume()
    }
    
    
}
