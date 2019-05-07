//
//  Product.swift
//  ESProductSearch
//
//  Created by Jolly Crisostomo on 2019/05/06.
//  Copyright © 2019 Jolly Crisostomo. All rights reserved.
//

import UIKit

class Product {
    var title: String
    var price: String
    var categories: String
    var photo: UIImage?
    var rating: Float
    
    init?(title: String, photo: UIImage?, rating: Float, price: String, categories: String) {
        
        // The name must not be empty
        guard !title.isEmpty else {
            return nil
        }
        
        // The rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        // Initialize store properties.
        self.title = title
        self.photo = photo
        self.rating = rating
        self.price = price
        self.categories = categories
    }
}
