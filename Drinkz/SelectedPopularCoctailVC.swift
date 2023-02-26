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
    
    @IBOutlet weak var coctailMeasuresTextView: UITextView!
    
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
        print("THis is count of ingredients : \(selectedDrink.ingredients)")
        print("THis is count of measures : \(selectedDrink.measures)")
//        for i in 0 ..< selectedDrink.ingredients.count {
//            coctailIngredientsTextView.text +=  "\(selectedDrink.ingredients[i]) \(selectedDrink.measures[i])"
//        }
        coctailMeasuresTextView.text = ""
        coctailIngredientsTextView.text = ""
        
        for i in 0 ..< selectedDrink.measures.count {
            coctailMeasuresTextView.text.append(contentsOf: selectedDrink.measures[i] + "\n")
        }
        
        for i in 0 ..< selectedDrink.ingredients.count {
            coctailIngredientsTextView.text.append(contentsOf: selectedDrink.ingredients[i] + "\n")
        }
        
    }
    
    @IBAction func backButtonTouched(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
}
