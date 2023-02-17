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
    
    @IBOutlet weak var coctailInstructionsText: UILabel!
    
    
    @IBOutlet weak var ingredient1: UILabel!
    
    @IBOutlet weak var ingredient2: UILabel!
    
    @IBOutlet weak var ingredient3: UILabel!
    
    @IBOutlet weak var ingredient4: UILabel!
   
    @IBOutlet weak var ingredient5: UILabel!
    
    @IBOutlet weak var ingredient6: UILabel!
    
    @IBOutlet weak var ingredient7: UILabel!
    
    @IBOutlet weak var ingredient8: UILabel!
    
    @IBOutlet weak var ingredient9: UILabel!
    
    @IBOutlet weak var ingredient10: UILabel!
    
    @IBOutlet weak var ingredient11: UILabel!
    
    @IBOutlet weak var ingredient12: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coctailImage.layer.cornerRadius = 50
    }
}
