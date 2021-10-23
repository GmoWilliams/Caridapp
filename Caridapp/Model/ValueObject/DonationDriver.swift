//
//  DonationDriver.swift
//  Caridapp
//
//  Created by user194082 on 10/22/21.
//

import Foundation

public class DonationDriver: Codable {
    public let donationID: Int;
    public let nameD: String;
    public let deliveryAddress: String;
    
    public init(id: Int, name: String, address: String){
        self.donationID = id;
        self.nameD = name;
        self.deliveryAddress = address;
    }
}
