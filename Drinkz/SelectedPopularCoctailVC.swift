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
    
    @IBOutlet weak var backButtonPressed: UIButton!
    
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
        
        let urlImage = URL(string: selectedDrink.strDrinkThumb)
        coctailImage.sd_setImage(with: urlImage)
        coctailNameLabel.text = selectedDrink.strDrink
        coctailCategoryLabel.text = selectedDrink.strCategory
        coctailGlassLabel.text = selectedDrink.strGlass
        coctailIsAlcoholicLabel.text = selectedDrink.strAlcoholic
        coctailInstructionsTextView.text = selectedDrink.strInstructions
        
    }
    
    @IBAction func backButtonTouched(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
}
