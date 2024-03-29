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
        cell.isFavoriteImage.isHidden = true
        cell.label.text = coctails[indexPath.item].name
        
        for i in favoriteCocktails {
            if coctails[indexPath.item].name == i.name {
                cell.isFavoriteImage.isHidden = false
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "myCocktail") as! SelectedPopularCoctailVC
        vc.drink = coctails[indexPath.item]
        self.navigationController?.show(vc, sender: nil)
    }
}

// Extension to IngredientsCoctailsListViewController to conform to UICollectionViewDelegateFlowLayout
extension LatestCocktailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCell = (view.frame.width - 10) / 2
        let heightCell = widthCell + 30
        return CGSize(width: widthCell, height: heightCell)
    }
}


