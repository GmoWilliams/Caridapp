//
//  LinePV.swift
//  Caridapp
//
//  Created by user196197 on 10/14/21.
//

import Foundation

public class LinePV: Decodable {
    public let donationID: Int64;
    public let lineID: Int64;
    //public let upc: Int64;
    public let itemName: String;
    //public let unitaryCost: Float;
    //public let expirationDate: Date;
    public let originalQuantity: Int;
    public let quantity: Int;
}
