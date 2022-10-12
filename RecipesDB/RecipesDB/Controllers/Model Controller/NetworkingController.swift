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
    private static let categoriesComponent = "categories"
    private static let filterComponent = "filter"
    private static let lookupComponent = "lookup"
    private static let php = "php"
    private static let queryItemC = "c"
    private static let queryItemI = "i"
    
    //MARK: - CRUD
    
    //Categories
    static func fetchCategories(completion: @escaping (Result<[Categories], ResultError>) -> Void) {
        guard let url = URL(string: baseURL) else {return}
        
                let categoriesURL = url.appendingPathComponent(categoriesComponent)
                let finalCategoriesURL = categoriesURL.appendingPathExtension(php)
                print(finalCategoriesURL)
        
        URLSession.shared.dataTask(with: finalCategoriesURL) { data, _, error in
            if let error {
                print("❌Something went wrong", error.localizedDescription)
                completion(.failure(.thrownError(error)))
                return
            }
            guard let categoriesData = data else {print("❌Something went wrong with the data"); completion(.failure(.noData)); return}
            
            do {
                let topLevelDictionary = try JSONDecoder().decode(CategoriesTopLevelDictionary.self, from: categoriesData)
                let categories = topLevelDictionary.categories
                completion(.success(categories))
            } catch {
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }//End of Func
    
    //Meals
    static func fetchMeals(for category: String, completion: @escaping (Result<[Meal], ResultError>) -> Void) {
        guard let url2 = URL(string: baseURL) else {return}
        
        let filterURL = url2.appendingPathComponent(filterComponent)
        let phpURL = filterURL.appendingPathExtension(php)
        //url query items
        var urlComponents = URLComponents(url: phpURL, resolvingAgainstBaseURL: true)
        let categoryQueryItem = URLQueryItem(name: queryItemC, value: category)
        urlComponents?.queryItems = [categoryQueryItem]
        guard let finalURL = urlComponents?.url else {completion(.failure(.invalidURL(url2))); return}
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { mealData, _, error in
            if let error {
                print("❌Something went wrong with the meal url", error.localizedDescription)
                completion(.failure(.thrownError(error)))
                return
            }
            guard let mealsData = mealData else {print("❌Something went wrong with the meals data"); completion(.failure(.noData)); return}
            
            do {
                let mealTopLevelDictionary = try JSONDecoder().decode(MealTopLevelDictionary.self, from: mealsData)
                let meals = mealTopLevelDictionary.meals
                completion(.success(meals))
            } catch {
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }//End of Func
    
    //Meal Detail
    static func fetchDetails(for meal: String, completion: @escaping (Result<[MealDetail], ResultError>) -> Void) {
        guard let url3 = URL(string: baseURL) else {return}
        
        let lookupURL = url3.appendingPathComponent(lookupComponent)
        let phpURL = lookupURL.appendingPathExtension(php)
        //URL query items
        var urlComponents = URLComponents(url: phpURL, resolvingAgainstBaseURL: true)
        let mealQueryItem = URLQueryItem(name: queryItemI, value: meal)
        urlComponents?.queryItems = [mealQueryItem]
        
        guard let finalURL = urlComponents?.url else {completion(.failure(.invalidURL(url3))); return}
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { detailData, _, error in
            if let error {
                print("❌Something went wrong with detail url", error.localizedDescription)
                completion(.failure(.thrownError(error)))
                return
            }
            guard let detailsData = detailData else {print("❌Something went wrong with the detail data"); completion(.failure(.noData)); return}
            
            do {
                let detailTopLevelObject = try JSONDecoder().decode(MealDetailsTopLevelDictionary.self, from: detailsData)
                let mealDetail = detailTopLevelObject.meals
                completion(.success(mealDetail))
            } catch {
                completion(.failure(.unableToDecode))
            }
        }.resume()
    }
}

//categories url: https://www.themealdb.com/api/json/v1/1/categories.php
//meals inside category url: https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood
//meal detail url: https://www.themealdb.com/api/json/v1/1/lookup.php?i=MEALID
