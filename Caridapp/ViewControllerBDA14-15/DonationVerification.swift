//
//  DonationVerification.swift
//  Caridapp
//
//  Created by user196197 on 10/21/21.
//

import Foundation

public class DonationVerificaion: Codable {
    public let donationID: Int64;
    public let warehouse: Int;
    
    public init (warehouse: Int, donationID: Int64) {
        self.donationID = donationID
        self.warehouse = warehouse;
    }
}
