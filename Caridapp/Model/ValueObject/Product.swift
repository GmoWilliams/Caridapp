//
//  Product.swift
//  Caridapp
//
//  Created by user194082 on 9/29/21.
//

import Foundation

public class Product {
    public let itemName: String;
    public let description: String;
    public let unitaryWeight: Float;
    public let unitaryCost: Float;
    public let expirationDate: Date;
    public let quantity: Int;
    
    public init (itemName: String, description: String, weight: Float, cost: Float, expirationDate: Date, quantity: Int){
        self.itemName = itemName;
        self.description = description;
        self.unitaryWeight = weight;
        self.unitaryCost = cost;
        self.expirationDate = expirationDate;
        self.quantity = quantity;
    }
}
