//
//  CategoriesListTableViewController.swift
//  RecipesDB
//
//  Created by Matheus Oliveira on 10/6/22.
//

import UIKit

class CategoriesListTableViewController: UITableViewController {
    
    var tempCategoriesArray: [Categories] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkingController.fetchCategories { categories in
            guard let categories = categories else {return}
            DispatchQueue.main.async {
                self.tempCategoriesArray = categories
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tempCategoriesArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        let category = tempCategoriesArray[indexPath.row]
        cell.imageView?.loadImageFrom(imageURL: category.strCategoryThumb)
        cell.textLabel?.text = category.strCategory
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toMealTableViewController",
              let destinationVC = segue.destination as? MealListTableViewController,
              let indexPath = tableView.indexPathForSelectedRow else {return}
        
        let categoryToSend = tempCategoriesArray[indexPath.row]
        destinationVC.categoryToReceive = categoryToSend
    }
}
