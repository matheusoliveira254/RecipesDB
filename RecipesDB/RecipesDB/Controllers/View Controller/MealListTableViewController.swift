//
//  MealListTableViewController.swift
//  RecipesDB
//
//  Created by Matheus Oliveira on 10/6/22.
//

import UIKit

class MealListTableViewController: UITableViewController {

    var categoryToReceive: Categories?
    var tempArrayMeal: [Meal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let categoryToReceive = categoryToReceive else {return}
        NetworkingController.fetchMeals(for: categoryToReceive.strCategory!) { meals in
            guard let meals = meals else {return}
            DispatchQueue.main.async {
                self.tempArrayMeal = meals
                self.tableView.reloadData()
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
