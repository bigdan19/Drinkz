//
//  SelectedCocktailViewController.swift
//  Drinkz
//
//  Created by Daniel on 28/02/2023.
//

import UIKit

class SelectedCocktailViewController: UIViewController {
    
    @IBOutlet weak var cocktailLabel: UILabel!
    
    @IBOutlet weak var cocktailCategoryLabel: UILabel!
    
    @IBOutlet weak var cocktailGlassLabel: UILabel!
    
    @IBOutlet weak var cocktailAlcoholicLabel: UILabel!
    
    @IBOutlet weak var cocktailImage: UIImageView!
    
    @IBOutlet weak var cocktailInstructionTextView: UITextView!
    
    @IBOutlet weak var cocktailIngredientTextView: UITextView!
    
    var stringForCoctail = "https://www.thecocktaildb.com/api/json/v2/9973533/lookup.php?i="
    var id: String?
    var drink: Drink?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let id = id {
            stringForCoctail.append(id)
            cocktailImage.layer.cornerRadius = 50
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButtonTapped))
            urlRequest(stringUrl: stringForCoctail)
        }
    }
    
    @objc func shareButtonTapped() {
        if let name = cocktailLabel.text, let category = cocktailCategoryLabel.text, let glass = cocktailGlassLabel.text, let alcoholic = cocktailAlcoholicLabel.text, let instructions = cocktailInstructionTextView.text, let ingredients = cocktailIngredientTextView.text {

            let textToShare = "\(name)\n\n\(name) is an \(alcoholic) \(category) that is served in a \(glass)\n\nInstructions\n\n\(instructions)\n\n\nIngredients\n\n\(ingredients)"
            let activityViewController = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
            present(activityViewController, animated: true, completion: nil)
        } else {
            print("error occured")
        }
    }
    
    func updateUI() {
        DispatchQueue.main.async {
            if let cocktail = self.drink {
                if let imageUrl = cocktail.imageUrl {
                    let url = URL(string: imageUrl)
                    self.cocktailImage.sd_setImage(with: url)
                }
                self.cocktailLabel.text = cocktail.name
                self.cocktailCategoryLabel.text = cocktail.category
                self.cocktailGlassLabel.text = cocktail.glass
                self.cocktailAlcoholicLabel.text = cocktail.alcoholic
                self.cocktailInstructionTextView.text = cocktail.instructions
                self.cocktailIngredientTextView.text = ""
                
                for i in 0..<max(cocktail.measures.count, cocktail.ingredients.count) {
                    if i < cocktail.measures.count {
                        self.cocktailIngredientTextView.text.append(cocktail.measures[i] + " ")
                    }
                    if i < cocktail.ingredients.count {
                        self.cocktailIngredientTextView.text.append(cocktail.ingredients[i] + "\n")
                    }
                }
            }
        }
    }
    
    func urlRequest(stringUrl: String) {
        guard let url = URL(string: stringUrl) else {
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
            } else {
                print("Error: Data could not be parsed")
            }
        }
        task.resume()
    }
    
    // Parsing json data
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonCoctail = try? decoder.decode(ListOfPopularDrinks.self, from: json) {
            drink = jsonCoctail.drinks[0]
            updateUI()
        } else {
            // I have to investigate as it is falling into error ... and printing this message
            print("Error occured decoding data")
        }
    }
}
