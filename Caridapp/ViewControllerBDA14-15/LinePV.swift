//
//  LinePV.swift
//  Caridapp
//
//  Created by user196197 on 10/14/21.
//

import Foundation

public class LinePV: Codable {
    public let donationID: Int64;
    public let lineID: Int64;
    public let itemName: String;
    public let productExpiration: Date;
    public let quantity: Int;
    
    public init (donationID: Int64, lineID: Int64, itemName: String , productExpiration: Date, quantity: Int) {
        self.donationID = donationID;
        self.lineID = lineID;
        self.itemName = itemName;
        self.productExpiration = productExpiration;
        self.quantity = quantity;
    }

}
