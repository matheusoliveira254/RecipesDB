//
//  Instructions.swift
//  RecipesDB
//
//  Created by Matheus Oliveira on 10/6/22.
//

import Foundation

class MealDetail {
    let strMeal: String?
    let strCategory: String?
    let strArea: String?
    let strInstructions: String?
    
    init(strMeal: String?, strCategory: String?, strArea: String?, strInstructions: String?) {
        self.strMeal = strMeal
        self.strCategory = strCategory
        self.strArea = strArea
        self.strInstructions = strInstructions
    }
}//End of Class

extension MealDetail {
    convenience init?(mealDetailDictionary: [String: Any]) {
        guard let mealName = mealDetailDictionary["strMeal"] as? String,
        let mealCategory = mealDetailDictionary["strCategory"] as? String,
        let mealOrigin = mealDetailDictionary["strArea"] as? String,
        let mealInstructions = mealDetailDictionary["strInstructions"] as? String else {return nil}
        
        self.init(strMeal: mealName, strCategory: mealCategory, strArea: mealOrigin, strInstructions: mealInstructions)
    }
}
/*
 {
             "idMeal": "52772",
             "strMeal": "Teriyaki Chicken Casserole",
             "strCategory": "Chicken",
             "strArea": "Japanese",
             "strInstructions": "Preheat oven to 350° F. Spray a 9x13-inch baking pan with non-stick spray.\r\nCombine soy sauce, ½ cup water, brown sugar, ginger and garlic in a small saucepan and cover. Bring to a boil over medium heat. Remove lid and cook for one minute once boiling.\r\nMeanwhile, stir together the corn starch and 2 tablespoons of water in a separate dish until smooth. Once sauce is boiling, add mixture to the saucepan and stir to combine. Cook until the sauce starts to thicken then remove from heat.\r\nPlace the chicken breasts in the prepared pan. Pour one cup of the sauce over top of chicken. Place chicken in oven and bake 35 minutes or until cooked through. Remove from oven and shred chicken in the dish using two forks.\r\n*Meanwhile, steam or cook the vegetables according to package directions.\r\nAdd the cooked vegetables and rice to the casserole dish with the chicken. Add most of the remaining sauce, reserving a bit to drizzle over the top when serving. Gently toss everything together in the casserole dish until combined. Return to oven and cook 15 minutes. Remove from oven and let stand 5 minutes before serving. Drizzle each serving with remaining sauce. Enjoy!",
             "strMealThumb": "https://www.themealdb.com/images/media/meals/wvpsxx1468256321.jpg",
             "strTags": "Meat,Casserole",
         }
 */
