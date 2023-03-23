//
//  LatestCocktailsViewController.swift
//  Drinkz
//
//  Created by Daniel on 07/03/2023.
//

import UIKit

class LatestCocktailsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var coctails = [Drink]()
    
    let urlString = "https://www.thecocktaildb.com/api/json/v2/9973533/latest.php"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        updateUI()
        
        NetworkManager.shared.loadDrinks(urlString: urlString) { drinks in
            guard let drinks = drinks else { return }
            self.coctails = drinks
            self.collectionView.reloadData()
        }
    }
    
    func updateUI() {
        title = "Latest Cocktails"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLatestCocktails" {
            let destinationVC = segue.destination as! SelectedPopularCoctailVC
            
            if let index = collectionView.indexPathsForSelectedItems?.first {
                let selectedDrink = coctails[index.item]
                destinationVC.drink = selectedDrink
            }
        }
    }
}

// Extension to LatestCocktailsViewController to conform to UICollectionViewDataSource
extension LatestCocktailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        coctails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularCoctailsCell", for: indexPath) as! PopularCoctailsCollectionViewCell
        if let imageUrl = coctails[indexPath.item].imageUrl {
            let url = URL(string: imageUrl)
            cell.image.sd_setImage(with: url)
        }
        cell.label.text = coctails[indexPath.item].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

// Extension to IngredientsCoctailsListViewController to conform to UICollectionViewDelegateFlowLayout
extension LatestCocktailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 210, height: 240)
    }
}


