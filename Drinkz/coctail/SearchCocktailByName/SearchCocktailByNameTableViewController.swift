//
//  SearchCocktailByNameTableViewController.swift
//  Drinkz
//
//  Created by Daniel on 03/03/2023.
//

import UIKit

class SearchCocktailByNameTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let urlString = "https://www.thecocktaildb.com/api/json/v2/9973533/search.php?s"
    
    
    var list = [Drink]()
    var searchList = [Drink]()
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        updateUI()
        NetworkManager.shared.loadDrinks(urlString: urlString) { drinks in
            guard let drinks = drinks else { return }
            self.list = drinks
            self.tableView.reloadData()
        }
    }
    
    func updateUI() {
        title = "Cocktails"
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
    
    // Creating cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cocktail", for: indexPath) as! SearchCoctailByNameTableViewCell
        if searching {
            if let imageUrl = searchList[indexPath.row].imageUrl {
                let url = URL(string: imageUrl)
                cell.cocktailImage.sd_setImage(with: url)
            }
            cell.cocktailLabel.text = searchList[indexPath.row].name
            cell.infoLabel.text = "category: \(searchList[indexPath.row].category.lowercased())\nglass: \(searchList[indexPath.row].glass.lowercased())"
        } else {
            if let imageUrl = list[indexPath.row].imageUrl {
                let url = URL(string: imageUrl)
                cell.cocktailImage.sd_setImage(with: url)
            }
            cell.cocktailLabel.text = list[indexPath.row].name
            cell.infoLabel.text = "category: \(list[indexPath.row].category.lowercased())\nglass: \(list[indexPath.row].glass.lowercased())"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "myCocktail") as! SelectedPopularCoctailVC
        if searching {
            vc.drink = searchList[indexPath.row]
        } else {
            vc.drink = list[indexPath.row]
        }
        self.navigationController?.show(vc, sender: nil)
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
}

// Search Bar filter function
extension SearchCocktailByNameTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchList = list.filter{ $0.name.lowercased().prefix(searchText.count) == searchText.lowercased()}
        searching = true
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // Search bar cancel button function
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
