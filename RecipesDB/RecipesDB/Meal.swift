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
    
    init(strMeal: String?, strMealThumb: String?) {
        self.strMeal = strMeal
        self.strMealThumb = strMealThumb
    }
}//End of CLass

extension Meal {
    convenience init?(mealDictionary: [String: String]) {
     guard let meal = mealDictionary["strMeal"],
        let image = mealDictionary["strMealThumb"] else {return nil}
        
        self.init(strMeal: meal, strMealThumb: image)
    }
}

/*
 {
             "strMeal": "Baked salmon with fennel & tomatoes",
             "strMealThumb": "https://www.themealdb.com/images/media/meals/1548772327.jpg",
             "idMeal": "52959"
         }
 */
