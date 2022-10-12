//
//  MealListTableViewController.swift
//  RecipesDB
//
//  Created by Matheus Oliveira on 10/6/22.
//

import UIKit

class MealListTableViewController: UITableViewController {
    
    var meals: Meal?
    var categoryToReceive: Categories?
    var tempArrayMeal: [Meal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let categoryToReceive = categoryToReceive else {return}
        NetworkingController.fetchMeals(for: categoryToReceive.strCategory!) { [weak self] result in
            switch result {
            case .success(let meals):
                self?.tempArrayMeal = meals
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
            }
            case .failure(let error):
                print("There was an error!", error.errorDescription!)
        }
    }
}

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempArrayMeal.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mealCell", for: indexPath)
        let meal = tempArrayMeal[indexPath.row]
        cell.imageView?.loadImageFrom(imageURL: meal.strMealThumb)
        cell.textLabel?.text = meal.strMeal
        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toMealDetailViewController",
              let destinationVC = segue.destination as? MealDetailViewController,
              let indexPath = tableView.indexPathForSelectedRow else {return}
        
        let mealToSend = tempArrayMeal[indexPath.row]
        destinationVC.mealToReceive = mealToSend
    }
}
