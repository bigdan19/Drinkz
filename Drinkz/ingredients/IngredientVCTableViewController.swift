//
//  IngredientVCTableViewController.swift
//  Drinkz
//
//  Created by Daniel on 08/03/2023.
//

import UIKit
import SDWebImage

class IngredientVCTableViewController: UITableViewController {

    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let urlString = "https://www.thecocktaildb.com/api/json/v2/9973533/list.php?i=list"
    let picURL = "https://www.thecocktaildb.com/images/ingredients/"
    
    // gin-Medium.png
    
    var list = [Ingredient]()
    var searchList = [Ingredient]()
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        urlRequest()
        title = "Ingredients"
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return searchList.count
        } else {
            return list.count
        }
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredient", for: indexPath) as! SearchByIngredientsTableViewCell
        if searching {
            cell.ingredientLabel.text = searchList[indexPath.row].strIngredient1
            let strUrl = "\(picURL)\(searchList[indexPath.row].strIngredient1.lowercased().replacingOccurrences(of: " ", with: "%20"))-Small.png"
            if let url = URL(string: strUrl) {
                cell.ingredientImage.sd_setImage(with: url)
            }
        } else {
            cell.ingredientLabel.text = list[indexPath.row].strIngredient1
            let strUrl = "\(picURL)\(list[indexPath.row].strIngredient1.lowercased().replacingOccurrences(of: " ", with: "%20"))-Small.png"
            if let url = URL(string: strUrl) {
                cell.ingredientImage.sd_setImage(with: url)
            } else {
                cell.ingredientImage.image = UIImage(named: "gin.png")
            }
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if searching {
            if let destination = segue.destination as? DetailIngredientViewController, let index = tableView.indexPathsForSelectedRows?.first {
                destination.picURL = URL(string: "\(picURL)\(searchList[index.row].strIngredient1.lowercased().replacingOccurrences(of: " ", with: "%20")).png")
                destination.ingredientStr = searchList[index.row].strIngredient1.lowercased().replacingOccurrences(of: " ", with: "%20")
            }
        } else {
            if let destination = segue.destination as? DetailIngredientViewController, let index = tableView.indexPathsForSelectedRows?.first {
                destination.picURL = URL(string: "\(picURL)\(list[index.row].strIngredient1.lowercased().replacingOccurrences(of: " ", with: "%20")).png")
                destination.ingredientStr = list[index.row].strIngredient1.lowercased().replacingOccurrences(of: " ", with: "%20")
            }
        }
        
    }

    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
}


extension IngredientVCTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchList = list.filter{ $0.strIngredient1.lowercased().prefix(searchText.count) == searchText.lowercased() }
        searching = true
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func IngredientVCTableViewController(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        // TODO - DISSMISS KEYBOARD WHEN CANCEL IS CLICKED
    }
}
