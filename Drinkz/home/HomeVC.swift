//
//  HomeVC.swift
//  Drinkz
//
//  Created by Daniel on 10/02/2023.
//

import UIKit
import SDWebImage

var favoriteCocktails = [Drink]()

class HomeVC: UIViewController {
    
    var popularDrinks = [Drink]()
    
    let urlString = "https://www.thecocktaildb.com/api/json/v2/9973533/popular.php"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Popular Cocktails"
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        NetworkManager.shared.loadDrinks(urlString: urlString) { drinks in
            guard let drinks = drinks else { return }
            self.popularDrinks = drinks
            self.collectionView.reloadData()
        }
        
        DrinksStorage.shared.loadFavourites()
    }
    
    // Pulling data from UserDefaults and decoding into array of coctails
    func decodeCocktails() {
        if let savedData = UserDefaults.standard.object(forKey: "cocktails") as? Data {
            let decoder = JSONDecoder()
            if let loadedData = try? decoder.decode([Drink].self, from: savedData) {
                favoriteCocktails = loadedData
            }
        }
    }
}

// extension to HomeVC to conform to DataSource
extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularDrinks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularCoctailsCell", for: indexPath) as! PopularCoctailsCollectionViewCell
        if let imageUrl = popularDrinks[indexPath.item].imageUrl {
            let url = URL(string: imageUrl)
            cell.image.sd_setImage(with: url)
        }
        cell.label.text = popularDrinks[indexPath.item].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "myCocktail") as! SelectedPopularCoctailVC
        vc.drink = popularDrinks[indexPath.item]
        self.navigationController?.show(vc, sender: nil)
    }
}

// extension to HomeVC to conform to DelegateFlowLayout
extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCell = (view.frame.width - 10) / 2
        let heightCell = widthCell + 30
        return CGSize(width: widthCell, height: heightCell)
    }
}
