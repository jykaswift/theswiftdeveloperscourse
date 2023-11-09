//
//  Product.swift
//  shop
//
//  Created by Евгений Борисов on 01.11.2023.
//

import Foundation
import UIKit

class Product {
    var name: String
    var description: String?
    var mainImage: UIImage
    var price: Int
    var otherImages = [UIImage]()
    
    internal init(name: String, mainImage: UIImage?, price: Int) {
        self.name = name
        self.price = price
        if let mainImage {
            self.mainImage = mainImage
        } else {
            self.mainImage = UIImage(systemName: "photo.artframe")!
        }
        
    }
    
    func addImage(image: UIImage?) {
        if let image {
            otherImages.append(image)
        }
    }
    
}
