//
//  SearchByIngredientsTableViewController.swift
//  Drinkz
//
//  Created by Daniel on 27/02/2023.
//

import UIKit

class SearchByIngredientsTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let urlString = "https://www.thecocktaildb.com/api/json/v2/9973533/list.php?i=list"
    let picURL = "https://www.thecocktaildb.com/images/ingredients/"
    
    var list = [Ingredient]()
    var searchList = [Ingredient]()
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        updateUI()
        NetworkManager.shared.loadListOfIngredients(urlString: urlString) { ingredients in
            guard let ingredients = ingredients else { return }
            self.list = ingredients
            self.tableView.reloadData()
        }
    }
    
    func updateUI() {
        title = "Ingredients"
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
            }
        }
        return cell
    }
    
    // Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? IngredientsCoctailsListViewController, let index = tableView.indexPathForSelectedRow {
            if searching {
                destination.ingredient = searchList[index.row].strIngredient1
            } else {
                destination.ingredient = list[index.row].strIngredient1
            }
        }
        
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    
}

extension SearchByIngredientsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchList = list.filter{ $0.strIngredient1.lowercased().prefix(searchText.count) == searchText.lowercased() }
        searching = true
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        // TODO - DISSMISS KEYBOARD WHEN CANCEL IS CLICKED
    }
}
