//
//  LineP.swift
//  Caridapp
//
//  Created by user190825 on 10/14/21.
//

import Foundation

public class LineP: Codable {
    public let donationID: Int64;
    public let lineID: Int64;
    public let upc: Int64;
    public let itemName: String;
    public let unitaryCost: Float;
    //public let expirationDate: Date;
    public let originalQuantity: Int;
    public let quantity: Int;
    
    public init (donationID: Int64, lineID: Int64, upc: Int64, itemName: String, unitaryCost: Float, originalQuantity: Int, quantity: Int) {
        self.donationID = donationID;
        self.lineID = lineID;
        self.upc = upc;
        self.itemName = itemName;
        self.unitaryCost = unitaryCost;
        self.originalQuantity = originalQuantity;
        self.quantity = quantity;
    }
}
