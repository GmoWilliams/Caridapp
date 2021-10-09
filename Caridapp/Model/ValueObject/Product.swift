//
//  Product.swift
//  Caridapp
//
//  Created by user194082 on 9/29/21.
//

import Foundation

public class Product: Codable {
    public let itemName: String;
    public let description: String;
    public let unitaryWeight: Float;
    public let unitaryCost: Float;
    public let expirationDate: Date;
    public let originalQuantity: Int;
    public let quantity: Int;
    
    public init (itemName: String, description: String, weight: Float, cost: Float, expirationDate: Date, orQuantity: Int, quantity: Int){
        self.itemName = itemName;
        self.description = description;
        self.unitaryWeight = weight;
        self.unitaryCost = cost;
        self.expirationDate = expirationDate;
        self.originalQuantity = orQuantity;
        self.quantity = quantity;
    }
}
