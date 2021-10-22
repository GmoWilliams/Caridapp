//
//  LineVerification.swift
//  Caridapp
//
//  Created by user196197 on 10/19/21.
//

import Foundation

public class LineVerificaion: Codable {
    public let donationID: Int64;
    public let lineID: Int64;
    public let productExpiration: Date;
    public let quantity: Int;
    
    public init (donationID: Int64, lineID: Int64, productExpiration: Date, quantity: Int) {
        self.donationID = donationID
        self.lineID = lineID;
        self.productExpiration = productExpiration;
        self.quantity = quantity;
    }
}
