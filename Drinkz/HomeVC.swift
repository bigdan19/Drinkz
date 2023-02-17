//
//  HomeVC.swift
//  Drinkz
//
//  Created by Daniel on 10/02/2023.
//

import UIKit
import SDWebImage

class HomeVC: UIViewController {
    
    var images: [UIImage] = []
    
    var popularDrinks = [Drink]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewWillLayoutSubviews() {
        
        let urlString = "https://www.thecocktaildb.com/api/json/v2/9973533/popular.php"
        
        
        if let url = URL(string: urlString) {
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    self.parse(json: data)
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                } else {
                    print("HTTP Request failed")
                }
            }
            task.resume()
        }
    }
    
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonDrinks = try? decoder.decode(listOfPopularDrinks.self, from: json) {
            popularDrinks = jsonDrinks.drinks
        } else {
            print("Error occured decoding data")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        images.append(UIImage(named: "drink1")!)
        images.append(UIImage(named: "drink2")!)
        images.append(UIImage(named: "drink3")!)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        
    }
}


extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        popularDrinks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularCoctailsCell", for: indexPath) as! PopularCoctailsCollectionViewCell
        let url = URL(string: popularDrinks[indexPath.item].strDrinkThumb)
        cell.image.sd_setImage(with: url)
        cell.label.text = popularDrinks[indexPath.item].strDrink
        return cell
    }
}

extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 210, height: 280)
    }
}
