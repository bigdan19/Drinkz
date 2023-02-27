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
    
    var drink: Drink!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coctailImage.layer.cornerRadius = 50
        guard let selectedDrink = drink else {
            print("Error no coctail being passed")
            return
        }
        if let imageUrl = selectedDrink.imageUrl {
            let url = URL(string: imageUrl)
            coctailImage.sd_setImage(with: url)
        }
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
    
    @IBAction func ShareButtonTapped(_ sender: Any) {
    }
    
}
