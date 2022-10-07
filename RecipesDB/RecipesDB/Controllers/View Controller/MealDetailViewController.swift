//
//  MealDetailViewController.swift
//  RecipesDB
//
//  Created by Matheus Oliveira on 10/6/22.
//

import UIKit

class MealDetailViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var mealPictureImageView: UIImageView!
    @IBOutlet weak var mealTitleLabel: UILabel!
    @IBOutlet weak var mealCategoryTextField: UITextField!
    @IBOutlet weak var mealOriginTextField: UITextField!
    @IBOutlet weak var mealIntructionsTextField: UITextView!
    
    
    var mealToReceive: Meal?
    var tempMealDetailArray: MealDetail?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let mealToReceive = mealToReceive else {return}
        NetworkingController.fetchDetails(for: mealToReceive.idMeal!) { details in
            guard let details = details else {return}
            DispatchQueue.main.async {
                self.tempMealDetailArray = details
                self.updateViews()
            }
        }
    }
    
    func updateViews() {
        mealTitleLabel.text = tempMealDetailArray?.strMeal
        mealCategoryTextField.text = tempMealDetailArray?.strCategory
        mealOriginTextField.text = tempMealDetailArray?.strArea
        mealIntructionsTextField.text = tempMealDetailArray?.strInstructions
        mealPictureImageView.loadImageFrom(imageURL: mealToReceive?.strMealThumb)
    }
}
