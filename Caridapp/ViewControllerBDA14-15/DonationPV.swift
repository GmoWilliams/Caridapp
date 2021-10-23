//
//  DonationPV.swift
//  Caridapp
//
//  Created by user196197 on 10/20/21.
//

import Foundation

public class DonationPV: Codable {
    
    public let donationID: Int64;
    public let pickUpDate: Date;
    public let warehouse: Int;
    
    public init (donationID: Int64, warehouse: Int, pickUpDate: Date) {
        self.donationID = donationID;
        self.warehouse = warehouse;
        self.pickUpDate = pickUpDate;
    }
}
