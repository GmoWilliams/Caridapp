//
//  Product.swift
//  Caridapp
//
//  Created by user194082 on 9/29/21.
//

import Foundation

public class Line: Codable {
    public let upc: Int64;
    public let unitaryCost: Float;
    public let expirationDate: Date;
    public let originalQuantity: Int;
    public let quantity: Int;
    public let name: String;
    
    public init (upc: Int64, cost: Float, expirationDate: Date, orQuantity: Int, quantity: Int, name: String){
        print("New line added")
        self.upc = upc;
        self.unitaryCost = cost;
        self.expirationDate = expirationDate;
        self.originalQuantity = orQuantity;
        self.quantity = quantity;
        self.name = name;
    }
}
