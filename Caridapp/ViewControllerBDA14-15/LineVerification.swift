//
//  LineVerification.swift
//  Caridapp
//
//  Created by user196197 on 10/19/21.
//

import Foundation

public class LineVerificaion: Codable {
    public let lineID: Int64;
    public let productExpiration: Date;
    public let originalQuantity: Int;
    public let quantity: Int;
    
    public init (lineID: Int64, unitaryCost: Float, productExpiration: Date, originalQuantity: Int, quantity: Int) {
        self.lineID = lineID;
        self.productExpiration = productExpiration;
        self.originalQuantity = originalQuantity;
        self.quantity = quantity;
    }
}
