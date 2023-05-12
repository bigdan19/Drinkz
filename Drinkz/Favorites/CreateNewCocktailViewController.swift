//
//  CreateNewCocktailViewController.swift
//  Drinkz
//
//  Created by Daniel on 17/04/2023.
//

import UIKit

class CreateNewCocktailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var categoryField: UITextField!
    @IBOutlet weak var glassField: UITextField!
    @IBOutlet weak var alcoholicField: UITextField!
    
    @IBOutlet weak var instructionField: UITextView!
    @IBOutlet weak var ingredientsField: UITextView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var addPictureButton: UIButton!
    
    var instructionsPlaceholderLabel: UILabel!
    var ingredientsPlaceholdferLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        self.dismissKeyboard()
    }
    
    func updateUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(savePressed))
        
        instructionField.delegate = self
        instructionsPlaceholderLabel = UILabel()
        instructionsPlaceholderLabel.text = "Enter some text..."
        instructionsPlaceholderLabel.font = .systemFont(ofSize: (ingredientsField.font?.pointSize)!)
        instructionsPlaceholderLabel.sizeToFit()
        instructionField.addSubview(instructionsPlaceholderLabel)
        instructionsPlaceholderLabel.frame.origin = CGPoint(x: 5, y: (instructionField.font?.pointSize)! / 2)
        instructionsPlaceholderLabel.textColor = .tertiaryLabel
        instructionsPlaceholderLabel.isHidden = !instructionField.text.isEmpty
        
        ingredientsField.delegate = self
        ingredientsPlaceholdferLabel = UILabel()
        ingredientsPlaceholdferLabel.text = "Enter some text..."
        ingredientsPlaceholdferLabel.font = .systemFont(ofSize: (ingredientsField.font?.pointSize)!)
        ingredientsPlaceholdferLabel.sizeToFit()
        ingredientsField.addSubview(ingredientsPlaceholdferLabel)
        ingredientsPlaceholdferLabel.frame.origin = CGPoint(x: 5, y: (ingredientsField.font?.pointSize)! / 2)
        ingredientsPlaceholdferLabel.textColor = .tertiaryLabel
        ingredientsPlaceholdferLabel.isHidden = !ingredientsField.text.isEmpty
        
        imageView.layer.cornerRadius = 40
        
        addPictureButton.isHidden = false
    }
    
    @objc func savePressed() {
        
    }
    
    @IBAction func addPicturePressed(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        
        // to continue
        
        imageView.image = image
        addPictureButton.isHidden = true
        dismiss(animated: true)
    }
    
}

extension CreateNewCocktailViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        instructionsPlaceholderLabel.isHidden = !instructionField.text.isEmpty
        ingredientsPlaceholdferLabel.isHidden = !ingredientsField.text.isEmpty
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        instructionsPlaceholderLabel.isHidden = !instructionField.text.isEmpty
        ingredientsPlaceholdferLabel.isHidden = !ingredientsField.text.isEmpty
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        instructionsPlaceholderLabel.isHidden = true
        ingredientsPlaceholdferLabel.isHidden = true
    }
}

extension CreateNewCocktailViewController {
func dismissKeyboard() {
       let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action:    #selector(CreateNewCocktailViewController.dismissKeyboardTouchOutside))
       tap.cancelsTouchesInView = false
       view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboardTouchOutside() {
       view.endEditing(true)
    }
}
