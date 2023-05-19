//
//  FavoritesViewController.swift
//  Drinkz
//
//  Created by Daniel on 15/03/2023.
//

import UIKit


class FavoritesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        title = "Favorites"
//        Have to create new coctail and add to array of favorites
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(addCocktail))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    
//    @objc func addCocktail() {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "createCocktail") as! CreateNewCocktailViewController
//        self.navigationController?.show(vc, sender: nil)
//    }
}




// extension to HomeVC to conform to DataSource
extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteCocktails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularCoctailsCell", for: indexPath) as! PopularCoctailsCollectionViewCell
        if let imageUrl = favoriteCocktails[indexPath.item].imageUrl {
            let url = URL(string: imageUrl)
            cell.image.sd_setImage(with: url)
        }
        cell.isFavoriteImage.isHidden = false
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "myCocktail") as! SelectedPopularCoctailVC
        vc.drink = favoriteCocktails[indexPath.item]
        self.navigationController?.show(vc, sender: nil)
    }
}

// extension to HomeVC to conform to DelegateFlowLayout
extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthCell = (view.frame.width - 10) / 2
        let heightCell = widthCell + 30
        return CGSize(width: widthCell, height: heightCell)
    }
}
