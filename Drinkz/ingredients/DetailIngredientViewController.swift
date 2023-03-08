//
//  DetailIngredientViewController.swift
//  Drinkz
//
//  Created by Daniel on 08/03/2023.
//

import UIKit

class DetailIngredientViewController: UIViewController {

    @IBOutlet weak var ingredientImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "www.thecocktaildb.com/images/ingredients/gin-Medium.png")
        ingredientImage.sd_setImage(with: url)
    }
    


}
