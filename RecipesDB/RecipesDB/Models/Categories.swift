//
//  Categories.swift
//  RecipesDB
//
//  Created by Matheus Oliveira on 10/6/22.
//

import Foundation

struct CategoriesTopLevelDictionary: Decodable {
    let categories: [Categories]
}

struct Categories: Decodable {
    let strCategory: String?
    let strCategoryThumb: String?
    
}//End of Class

//extension Categories {
//    convenience init?(categoriesDictionary: [String: String]) {
//        guard let categories = categoriesDictionary["strCategory"],
//              let image = categoriesDictionary["strCategoryThumb"] else {return nil}
//
//        self.init(strCategory: categories, strCategoryThumb: image)
//    }
//}
/*
 {
             "idCategory": "1",
             "strCategory": "Beef",
             "strCategoryThumb": "https://www.themealdb.com/images/category/beef.png",
             "strCategoryDescription": "Beef is the culinary name for meat from cattle, particularly skeletal muscle. Humans have been eating beef since prehistoric times.[1] Beef is a source of high-quality protein and essential nutrients.[2]"
         }
 */
