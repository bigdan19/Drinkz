//
//  DetailIngredientViewController.swift
//  Drinkz
//
//  Created by Daniel on 08/03/2023.
//

import UIKit

class DetailIngredientViewController: UIViewController {

    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var ingredientImage: UIImageView!
    @IBOutlet weak var itemTextView: UITextView!
    
    
    var picURL: URL?
    var item: Item?
    
    var ingredientURL = "https://www.thecocktaildb.com/api/json/v2/9973533/search.php?i="
    var ingredientStr: String?
    
    
    // TODO CREATE SCROLLVIEW TO SEE DETAILED PAGE INSTEAD OF SCROLLABLE TEXTVIEW
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let sUrl = picURL {
            ingredientImage.sd_setImage(with: sUrl)
        }
        
        if let inStr = ingredientStr {
            ingredientURL += inStr
            print(ingredientURL)
            urlRequest()
        }
    }
    
    func reloadView() {
        ingredientLabel.text = item?.strIngredient
        itemTextView.text = item?.strDescription
    }
    
    // Creating urlRequest
    func urlRequest() {
        // Create url from String
        guard let url = URL(string: ingredientURL) else {
            print("Error: cannot create URL from String")
            return
        }
        // Creating task(URL Session)
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            // Checking data and parsing it
            if let data = data {
                self.parse(json: data)
                DispatchQueue.main.async {
                    self.reloadView()
                }
            } else {
                print("Error: Data could not be parsed")
            }
        }
        task.resume()
    }
    
    // Parsing json data
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonIngredients = try? decoder.decode(Ingredients.self, from: json) {
            item = jsonIngredients.ingredients.first
        } else {
            print("Error occured decoding data")
        }
    }
    


}
