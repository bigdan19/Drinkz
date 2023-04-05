//
//  SelectedPopularCoctailVC.swift
//  Drinkz
//
//  Created by Daniel on 13/02/2023.
//

import UIKit
import SDWebImage

class SelectedPopularCoctailVC: UIViewController {
    
    @IBOutlet weak var coctailNameLabel: UILabel!
    
    @IBOutlet weak var coctailImage: UIImageView!
    
    @IBOutlet weak var coctailCategoryLabel: UILabel!
    
    @IBOutlet weak var coctailGlassLabel: UILabel!
    
    @IBOutlet weak var coctailIsAlcoholicLabel: UILabel!
    
    @IBOutlet weak var coctailInstructionsTextView: UITextView!
    
    @IBOutlet weak var coctailIngredientsTextView: UITextView!
    
    @IBOutlet weak var addToFavoritesButton: UIButton!
    
    var drink: Drink?
    
    var coctailString: String?
    
    var isFavorite: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //checking if there is no drink structure and it need to be loaded using loadDrinks function
        if let coctailString = coctailString {
            NetworkManager.shared.loadDrinks(urlString: coctailString) { drinks in
                guard let drinks = drinks else { return }
                self.drink = drinks.first
                self.checkIfIsInFavorites()
                self.updateUI()
            }
        } else {
            updateUI()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        checkIfIsInFavorites()
    }
    
    // StarButton pressed (add to favorites button)
    @IBAction func addToFavoritesPressed(_ sender: Any) {
        guard let drink = drink else {
            return
        }
        if isFavorite {
            isFavorite = false
            addToFavoritesButton.setImage(UIImage(named: "add.png"), for: .normal)
            for i in 0..<favoriteCocktails.count{
                if drink.name == favoriteCocktails[i].name {
                    favoriteCocktails.remove(at: i)
                    DrinksStorage.shared.saveFavorites(favoriteCocktails: favoriteCocktails)
                    return
                }
            }
        } else {
            isFavorite = true
            addToFavoritesButton.setImage(UIImage(named: "added.png"), for: .normal)
            favoriteCocktails.append(drink)
            DrinksStorage.shared.saveFavorites(favoriteCocktails: favoriteCocktails)
        }
    }
    
    // Updating UI
    func updateUI () {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButtonTapped))
        guard let selectedDrink = drink else {
            print("Error no coctail being passed")
            return
        }
        if let imageUrl = selectedDrink.imageUrl {
            let url = URL(string: imageUrl)
            coctailImage.sd_setImage(with: url)
        }
        coctailImage.layer.cornerRadius = 50
        coctailNameLabel.text = selectedDrink.name
        coctailCategoryLabel.text = selectedDrink.category
        coctailGlassLabel.text = selectedDrink.glass
        coctailIsAlcoholicLabel.text = selectedDrink.alcoholic
        coctailInstructionsTextView.text = selectedDrink.instructions
        coctailIngredientsTextView.text = ""
        
        for i in 0..<max(selectedDrink.measures.count, selectedDrink.ingredients.count) {
            if i < selectedDrink.measures.count {
                coctailIngredientsTextView.text.append(selectedDrink.measures[i] + " ")
            }
            if i < selectedDrink.ingredients.count {
                coctailIngredientsTextView.text.append(selectedDrink.ingredients[i] + "\n")
            }
        }
    }
    // Checking if cocktail is in favorites array
    func checkIfIsInFavorites() {
        if let cocktail = drink {
            for i in favoriteCocktails {
                if cocktail.name == i.name {
                    addToFavoritesButton.setImage(UIImage(named: "added.png"), for: .normal)
                    isFavorite = true
                    return
                } else {
                    addToFavoritesButton.setImage(UIImage(named: "add.png"), for: .normal)
                    isFavorite = false
                }
            }
        }
    }
    
    // Share button to share coctail recipe
    @objc func shareButtonTapped() {
        if let name = coctailNameLabel.text, let category = coctailCategoryLabel.text, let glass = coctailGlassLabel.text, let alcoholic = coctailIsAlcoholicLabel.text, let instructions = coctailInstructionsTextView.text, let ingredients = coctailIngredientsTextView.text {
            let textToShare = "\(name)\n\n\(name) is an \(alcoholic) \(category) that is served in a \(glass)\n\nInstructions\n\n\(instructions)\n\n\nIngredients\n\n\(ingredients)"
            let activityViewController = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
            present(activityViewController, animated: true, completion: nil)
        } else {
            print("error occured")
        }
    }
}
