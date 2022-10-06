//
//  NetworkingController.swift
//  RecipesDB
//
//  Created by Matheus Oliveira on 10/6/22.
//

import Foundation

class NetworkingController {

    //Keys
    private static let baseURL = "https://www.themealdb.com"
    private static let apiComponent = "api"
    private static let JSONComponent = "json/v1"
    private static let apiKey = "1"
    private static let categoriesEndPoint = "categories.php"
    private static let specificCategoryQuery = "filter.php?c="
    private static let mealDetailsByIDQuery = "lookup.php?i="
    
    //MARK: - CRUD
    static func fetchCategories(completion: @escaping ([Categories]?) -> Void) {
        guard let url = URL(string: baseURL) else {completion(nil); return}
        
        let apiURL = url.appendingPathComponent(apiComponent)
        let jsonURL = apiURL.appendingPathComponent(JSONComponent)
        let apiKeyURL = jsonURL.appendingPathComponent(apiKey)
        let finalCategoriesURL = apiKeyURL.appendingPathComponent(categoriesEndPoint)
        print(finalCategoriesURL)
        
        URLSession.shared.dataTask(with: finalCategoriesURL) { data, _, error in
            if let error {
                print("❌Something went wrong", error.localizedDescription)
                completion(nil)
                return
            }
            guard let categoriesData = data else {print("❌Something went wrong with the data"); completion(nil); return}
            
            do {
                if let topLevelDictionary = try? JSONSerialization.jsonObject(with: categoriesData) as? [String: String] {
                    if let categories = topLevelDictionary["categories"] as? [[String: String]] {
                        var categoriesArray: [Categories] = []
                        for categoryDictionary in categories {
                            guard let category = Categories(categoriesDictionary: categoryDictionary) else {completion(nil); return}
                            categoriesArray.append(category)
                        }
                        completion(categoriesArray)
                    }
                }
            }
        }.resume()
    }//End of Func
    static func fetchMeals(for category: Categories, completion: @escaping ([Meal]?) -> Void) {
        guard let url = URL(string: baseURL) else {completion(nil); return}
        guard let categoryQuery = category.strCategory else {completion(nil); return}
        let apiURL = url.appendingPathComponent(apiComponent)
        let jsonURL = apiURL.appendingPathComponent(JSONComponent)
        let mealsInCategoryURL = jsonURL.appendingPathComponent(specificCategoryQuery)
        let finalURL = mealsInCategoryURL.appendingPathComponent(categoryQuery)
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { mealData, _, error in
            if let error {
                print("❌Something went wrong with the meal url", error.localizedDescription)
                completion(nil)
                return
            }
            guard let mealsData = mealData else {print("❌Something went wrong with the meals data"); completion(nil); return}
            
            do {
                if let mealTopLevelDictionary = try? JSONSerialization.jsonObject(with: mealsData) as? [String: String] {
                    if let meals = mealTopLevelDictionary["meals"] as? [[String: String]] {
                        var mealsArray: [Meal] = []
                        for mealDictionary in meals {
                            guard let meal = Meal(mealDictionary: mealDictionary) else {completion(nil); return}
                            mealsArray.append(meal)
                        }
                        completion(mealsArray)
                    }
                }
            }
        }.resume()
    }
}

//categories url: www.themealdb.com/api/json/v1/1/categories.php
//meals inside category url: www.themealdb.com/api/json/v1/1/filter.php?c=Seafood
//meal detail url: www.themealdb.com/api/json/v1/1/lookup.php?i=MEALID
