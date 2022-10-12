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
    var tempMealDetailArray: [MealDetail]?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let mealToReceive = mealToReceive else {return}
        NetworkingController.fetchDetails(for: mealToReceive.idMeal!) { [weak self] result in
            switch result {
            case .success(let mealDetails):
                self?.tempMealDetailArray = mealDetails
                DispatchQueue.main.async {
                    self?.updateViews()
                }
            case .failure(let error):
                print("There was an error!", error.errorDescription!)
            }
        }
    }
    
    func updateViews() {
        guard let tempArray = tempMealDetailArray else {return}
        mealTitleLabel.text = tempArray[0].strMeal
        mealCategoryTextField.text = tempArray[0].strCategory
        mealOriginTextField.text = tempArray[0].strArea
        mealIntructionsTextField.text = tempArray[0].strInstructions
        mealPictureImageView.loadImageFrom(imageURL: mealToReceive?.strMealThumb)
    }
}
