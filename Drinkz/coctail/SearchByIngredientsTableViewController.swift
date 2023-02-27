//
//  SearchByIngredientsTableViewController.swift
//  Drinkz
//
//  Created by Daniel on 27/02/2023.
//

import UIKit

class SearchByIngredientsTableViewController: UITableViewController {
    
    let urlString = "https://www.thecocktaildb.com/api/json/v2/9973533/list.php?i=list"
    
    var list = [Ingredient]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ingredients"
        urlRequest()
    }
    
    // Creating urlRequest
    func urlRequest() {
        // Create url from String
        guard let url = URL(string: urlString) else {
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
                    self.tableView.reloadData()
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
        
        if let jsonIngredients = try? decoder.decode(ListOfIngredients.self, from: json) {
            list = jsonIngredients.drinks
        } else {
            print("Error occured decoding data")
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredient", for: indexPath) as! SearchByIngredientsTableViewCell
        cell.ingredientLabel.text = list[indexPath.row].strIngredient1
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? IngredientsCoctailsListViewController, let index = tableView.indexPathForSelectedRow {
            destination.ingredient = list[index.row].strIngredient1
        }
        
    }
    
}
