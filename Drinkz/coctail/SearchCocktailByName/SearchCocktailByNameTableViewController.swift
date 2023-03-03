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
        urlRequest()
    }
    
    func updateUI() {
        title = "Cocktails"
    }
    
    func urlRequest(){
        guard let url = URL(string: urlString) else {
            print("Error: cannot create URL from String")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
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
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonCocktails = try? decoder.decode(ListOfPopularDrinks.self, from: json) {
            list = jsonCocktails.drinks
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
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
}

extension SearchCocktailByNameTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchList = list.filter{ $0.name.lowercased().prefix(searchText.count) == searchText.lowercased()}
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
    }
}
