//
//  DonationVerification.swift
//  Caridapp
//
//  Created by user196197 on 10/21/21.
//

import Foundation

public class DonationVerification: Codable {
    public let donationID: Int64;
    public let warehouse: Int;
    
    public init (donationID: Int64, warehouse: Int) {
        self.donationID = donationID
        self.warehouse = warehouse;
    }
}
