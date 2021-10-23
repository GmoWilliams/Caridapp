//
//  Product.swift
//  Caridapp
//
//  Created by user194082 on 10/9/21.
//
import Foundation

public class Product: Codable {
    public let upc: Int64;
    public let itemName: String;
    public let description: String;
    public let unitaryWeight: Double;
    
    public init (upc: Int64, itemName: String, description: String, unitaryWeight: Double) {
        self.upc = upc;
        self.itemName = itemName;
        self.description = description;
        self.unitaryWeight = unitaryWeight;
    }
}
