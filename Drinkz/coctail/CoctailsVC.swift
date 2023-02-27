//
//  CoctailsVC.swift
//  Drinkz
//
//  Created by Daniel on 10/02/2023.
//

import UIKit

class CoctailsVC: UIViewController {
    
    @IBOutlet weak var searchByIngredientLabel: UIButton!
    @IBOutlet weak var searchByIngredientPicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Coctails Search"
        searchByIngredientPicture.layer.cornerRadius = 25
        searchByIngredientLabel.layer.masksToBounds = true
        searchByIngredientLabel.layer.cornerRadius = 15
    }
    
    
    
    @IBAction func searchByIngredientButtonPressed(_ sender: Any) {
        
    }
    

}
