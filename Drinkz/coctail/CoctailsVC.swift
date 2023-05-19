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
    
    @IBOutlet weak var searchByNamePicture: UIImageView!
    @IBOutlet weak var searchByNameLabel: UIButton!
    
    @IBOutlet weak var searchMostLatestCoctailsPicture: UIImageView!
    @IBOutlet weak var searchMostLatestCoctailsLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI () {
        title = "Cocktails"
        searchByIngredientPicture.layer.cornerRadius = 25
        searchByIngredientLabel.layer.masksToBounds = true
        searchByIngredientLabel.layer.cornerRadius = 15
        searchByNamePicture.layer.cornerRadius = 25
        searchByNameLabel.layer.masksToBounds = true
        searchByNameLabel.layer.cornerRadius = 15
        searchMostLatestCoctailsPicture.layer.cornerRadius = 25
        searchMostLatestCoctailsLabel.layer.masksToBounds = true
        searchMostLatestCoctailsLabel.layer.cornerRadius = 15
    }
    
    
    
    @IBAction func searchByIngredientButtonPressed(_ sender: Any) {
    }
    
    
    @IBAction func searchByNameButtonPressed(_ sender: Any) {
    }
    
    @IBAction func searchMostLatestCoctailsButtonPressed(_ sender: Any) {
    }
    
    
}
