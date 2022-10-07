//
//  UIImageView.swift
//  RecipesDB
//
//  Created by Matheus Oliveira on 10/7/22.
//

import UIKit

extension UIImageView {
    
    //Func created to create an image from a URL
    func loadImageFrom(imageURL: String?) {
        guard let imageURL = imageURL else {return}
        guard let url = URL(string: imageURL) else {return}
        
        URLSession.shared.dataTask(with: url) { imageData, _, error in
            if let error {
                DispatchQueue.main.async {
                    self.image = UIImage(named: "image_default_food")
                    print("Error Displaying Image!!")
                }
            }
            
            if let data = imageData {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }.resume()
    }
}
