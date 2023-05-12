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
        cell.isFavoriteImage.isHidden = true
        cell.label.text = coctails[indexPath.item].strDrink
        
        for i in favoriteCocktails {
            if coctails[indexPath.item].strDrink == i.name {
                cell.isFavoriteImage.isHidden = false
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "myCocktail") as! SelectedPopularCoctailVC
        vc.coctailString = stringForCoctail + coctails[indexPath.item].idDrink
        self.navigationController?.show(vc, sender: nil)
    }
}

// Extension to IngredientsCoctailsListViewController to conform to UICollectionViewDelegateFlowLayout
extension IngredientsCoctailsListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCell = (view.frame.width - 10) / 2
        let heightCell = widthCell + 30
        return CGSize(width: widthCell, height: heightCell)
    }
}
