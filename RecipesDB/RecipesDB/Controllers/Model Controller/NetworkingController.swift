//
//  NetworkingController.swift
//  RecipesDB
//
//  Created by Matheus Oliveira on 10/6/22.
//

import Foundation

class NetworkingController {

    //Keys
    private static let baseURL = "https://www.themealdb.com/api/json/v1/1"
//    private static let apiComponent = "api"
//    private static let JSONComponent = "json/v1"
//    private static let apiKey = "1"
    private static let categoriesComponent = "categories"
    private static let filterComponent = "filter"
    private static let mealDetailsByIDQuery = "lookup"
    private static let php = "php"
    private static let queryItemC = "c"
    private static let queryItemI = "i"
    
    //MARK: - CRUD
    
    //Categories
    static func fetchCategories(completion: @escaping ([Categories]?) -> Void) {
        guard let url = URL(string: baseURL) else {completion(nil); return}
        
        let categoriesURL = url.appendingPathComponent(categoriesComponent)
        let finalCategoriesURL = categoriesURL.appendingPathExtension(php)
        print(finalCategoriesURL)
        
        URLSession.shared.dataTask(with: finalCategoriesURL) { data, _, error in
            if let error {
                print("❌Something went wrong", error.localizedDescription)
                completion(nil)
                return
            }
            guard let categoriesData = data else {print("❌Something went wrong with the data"); completion(nil); return}
            
            do {
                if let topLevelDictionary = try? JSONSerialization.jsonObject(with: categoriesData) as? [String: Any] {
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

    //Meals
    static func fetchMeals(for category: String, completion: @escaping ([Meal]?) -> Void) {
        guard let url = URL(string: baseURL) else {completion(nil); return}
        
        let filterURL = url.appendingPathComponent(filterComponent)
        let phpURL = filterURL.appendingPathExtension(php)
        //url query items
        var urlComponents = URLComponents(url: phpURL, resolvingAgainstBaseURL: true)
        let categoryQueryItem = URLQueryItem(name: queryItemC, value: category)
        urlComponents?.queryItems = [categoryQueryItem]
        guard let finalURL = urlComponents?.url else {completion(nil); return}
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { mealData, _, error in
            if let error {
                print("❌Something went wrong with the meal url", error.localizedDescription)
                completion(nil)
                return
            }
            guard let mealsData = mealData else {print("❌Something went wrong with the meals data"); completion(nil); return}
            
            do {
                if let mealTopLevelDictionary = try? JSONSerialization.jsonObject(with: mealsData) as? [String: Any] {
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
    }//End of Func
    
    //Meal Detail
    static func fetchDetails(for meal: Meal, completion: @escaping (MealDetail?) -> Void) {
        guard let url = URL(string: baseURL) else {completion(nil); return}
        guard let mealQuery = meal.idMeal else {completion(nil); return}
//        
//        let apiURL = url.appendingPathComponent(apiComponent)
//        let jsonURL = apiURL.appendingPathComponent(JSONComponent)
//        let mealDetailURL = jsonURL.appendingPathComponent(mealDetailsByIDQuery)
//        let finalURL = mealDetailURL.appendingPathExtension(mealQuery)
    }
}

//categories url: https://www.themealdb.com/api/json/v1/1/categories.php
//meals inside category url: https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood
//meal detail url: https://www.themealdb.com/api/json/v1/1/lookup.php?i=MEALID
