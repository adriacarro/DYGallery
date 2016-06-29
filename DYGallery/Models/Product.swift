//
//  Product.swift
//  DYGallery
//
//  Created by Adrià Carro on 28/06/16.
//  Copyright © 2016 DigitalYou. All rights reserved.
//

class Product {
    
    var name: String
    var activeImage: Int
    var images: [String]
    var image: String {
        return images[activeImage]
    }
    
    static func getProducts() -> [Product] {
        return [
            Product(name: "Product 0", images: ["0", "1", "2", "3", "4", "5"]),
            Product(name: "Product 1", images: ["1", "2", "3", "4", "5", "0"]),
            Product(name: "Product 2", images: ["2", "3", "4", "5", "0", "1"]),
            Product(name: "Product 3", images: ["3", "4", "5", "0", "1", "2"]),
            Product(name: "Product 4", images: ["4", "5", "0", "1", "2", "3"]),
            Product(name: "Product 5", images: ["5", "0", "1", "2", "3", "4"]),
            Product(name: "Product 6", images: ["0", "1", "2", "3", "4", "5"]),
            Product(name: "Product 7", images: ["1", "2", "3", "4", "5", "0"]),
            Product(name: "Product 8", images: ["2", "3", "4", "5", "0", "1"]),
            Product(name: "Product 9", images: ["3", "4", "5", "0", "1", "2"]),
            Product(name: "Product 10", images: ["4", "5", "0", "1", "2", "3"]),
            Product(name: "Product 11", images: ["5", "0", "1", "2", "3", "4"])
        ]
    }
    
    init(name: String, images: [String]) {
        self.name = name
        self.images = images
        self.activeImage = 0
    }
    
}
