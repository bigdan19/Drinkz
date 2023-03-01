//
//  IngredientsCoctailsListViewController.swift
//  Drinkz
//
//  Created by Daniel on 27/02/2023.
//

import UIKit

class IngredientsCoctailsListViewController: UIViewController {
    
    
    var urlString = "https://www.thecocktaildb.com/api/json/v2/9973533/filter.php?i="
    var ingredient: String!
    
    var coctails = [Coctail]()

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ingredient
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        urlRequest()
    }
    
    // Creating urlRequest
    func urlRequest() {
        guard let ingredientURL = ingredient else {
            print("Error getting ingredient")
            return
        }
        urlString.append(ingredientURL.lowercased().replacingOccurrences(of: " ", with: "%20"))
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
                    self.collectionView.reloadData()
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
        
        if let jsonCoctails = try? decoder.decode(ListOfCoctails.self, from: json) {
            coctails = jsonCoctails.drinks
        } else {
            print("Error occured decoding data")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SelectedCocktailViewController, let index = collectionView.indexPathsForSelectedItems?.first {
            destination.id = coctails[index.row].idDrink
            }
        }
    }


extension IngredientsCoctailsListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        coctails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularCoctailsCell", for: indexPath) as! PopularCoctailsCollectionViewCell
        if let imageUrl = coctails[indexPath.item].strDrinkThumb {
            let url = URL(string: imageUrl)
            cell.image.sd_setImage(with: url)
        }
        cell.label.text = coctails[indexPath.item].strDrink
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    
    
    
    
    
}

extension IngredientsCoctailsListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 210, height: 280)
    }
}
