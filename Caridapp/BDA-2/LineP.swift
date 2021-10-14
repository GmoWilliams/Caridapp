//
//  LineP.swift
//  Caridapp
//
//  Created by user190825 on 10/14/21.
//

import Foundation

public class LineP: Decodable {
    public let upc: Int64;
    public let itemName: String;
    public let unitaryCost: Float;
    //public let expirationDate: Date;
    public let originalQuantity: Int;
    public let quantity: Int;
}
