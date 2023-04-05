//
//  IngredientsCoctailsListViewController.swift
//  Drinkz
//
//  Created by Daniel on 27/02/2023.
//

import UIKit

class IngredientsCoctailsListViewController: UIViewController {
    
    
    var urlString = "https://www.thecocktaildb.com/api/json/v2/9973533/filter.php?i="
    
    var stringForCoctail = "https://www.thecocktaildb.com/api/json/v2/9973533/lookup.php?i="
    
    var ingredient: String?
    
    var coctails = [Coctail]()
    
    var drinks = [Drink]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        updateUI()
        urlRequest()
    }
    
    func updateUI (){
        title = ingredient
    }
    
    // Creating urlRequest
    func urlRequest() {
        guard let ingredientURL = ingredient else {
            print("Error getting ingredient")
            return
        }
        // Creating URL that has ingredient key ( if there is space replaced with %20)
        urlString.append(ingredientURL.lowercased().replacingOccurrences(of: " ", with: "%20"))
        NetworkManager.shared.loadListOfCoctailsFromIngredients(urlString: urlString) { drinks in
            guard let drinks = drinks else { return }
            self.coctails = drinks
            self.collectionView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SelectedPopularCoctailVC, let index = collectionView.indexPathsForSelectedItems?.first {
            destination.coctailString = stringForCoctail + coctails[index.item].idDrink
        }
    }
}


// Extension to IngredientsCoctailsListViewController to conform to UICollectionViewDataSource
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
}

// Extension to IngredientsCoctailsListViewController to conform to UICollectionViewDelegateFlowLayout
extension IngredientsCoctailsListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 210, height: 240)
    }
}
