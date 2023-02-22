//
//  SelectedPopularCoctailVC.swift
//  Drinkz
//
//  Created by Daniel on 13/02/2023.
//

import UIKit

class SelectedPopularCoctailVC: UIViewController {
    
    @IBOutlet weak var coctailImage: UIImageView!
    
    @IBOutlet weak var coctailCategoryLabel: UILabel!
    
    @IBOutlet weak var coctailGlassLabel: UILabel!
    
    @IBOutlet weak var coctailIsAlcoholicLabel: UILabel!
    
    
    @IBOutlet weak var coctailInstructionsTextView: UITextView!
    
    @IBOutlet weak var coctailIngredientsTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coctailImage.layer.cornerRadius = 50
    }
}
