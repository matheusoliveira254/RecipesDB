//
//  Meal.swift
//  RecipesDB
//
//  Created by Matheus Oliveira on 10/6/22.
//

import Foundation

class Meal {
    let strMeal: String?
    let strMealThumb: String?
    let idMeal: String?
    
    init(strMeal: String?, strMealThumb: String?, idMeal: String?) {
        self.strMeal = strMeal
        self.strMealThumb = strMealThumb
        self.idMeal = idMeal
    }
}//End of CLass

extension Meal {
    convenience init?(mealDictionary: [String: String]) {
        guard let meal = mealDictionary["strMeal"],
              let image = mealDictionary["strMealThumb"],
              let id = mealDictionary["idMeal"] else {return nil}
        
        self.init(strMeal: meal, strMealThumb: image, idMeal: id)
    }
}

/*
 {
             "strMeal": "Baked salmon with fennel & tomatoes",
             "strMealThumb": "https://www.themealdb.com/images/media/meals/1548772327.jpg",
             "idMeal": "52959"
         }
 */
