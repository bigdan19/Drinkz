//
//  HomeVC.swift
//  Drinkz
//
//  Created by Daniel on 10/02/2023.
//

import UIKit
import SDWebImage

class HomeVC: UIViewController {
    
    var popularDrinks = [Drink]()
    
    let urlString = "https://www.thecocktaildb.com/api/json/v2/9973533/popular.php"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewWillLayoutSubviews() {
        urlRequest()
    }
    
    // Creating urlRequest
    func urlRequest() {
        // Create url from String
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
        
        if let jsonDrinks = try? decoder.decode(listOfPopularDrinks.self, from: json) {
            popularDrinks = jsonDrinks.drinks
        } else {
            print("Error occured decoding data")
        }
    }
    
//    func showErrorAlert(title errorTitle: String, message errorMessage: String) {
//        let alertController = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
//        alertController.addAction(okAction)
//        present(alertController, animated: true, completion: nil)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SelectedPopularCoctailVC, let index = collectionView.indexPathsForSelectedItems?.first {
            destination.drink = popularDrinks[index.row]
        }
    }
}


extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        popularDrinks.count
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
        // Have to create a segue or programmatricaly to load vc with drinks
        // pushToDrinkVC
        
    }
}

extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 210, height: 280)
    }
}
