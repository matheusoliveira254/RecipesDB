//
//  Meal.swift
//  RecipesDB
//
//  Created by Matheus Oliveira on 10/6/22.
//

import Foundation

struct MealTopLevelDictionary: Decodable {
    let meals: [Meal]
}

struct Meal: Decodable {
    let strMeal: String?
    let strMealThumb: String?
    let idMeal: String?
    
}//End of CLass

/*
 {
             "strMeal": "Baked salmon with fennel & tomatoes",
             "strMealThumb": "https://www.themealdb.com/images/media/meals/1548772327.jpg",
             "idMeal": "52959"
         }
 */
