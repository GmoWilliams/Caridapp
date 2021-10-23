//
//  LineUpdate.swift
//  Caridapp
//
//  Created by user190825 on 10/18/21.
//
import Foundation
// This class is made to match the required data for UpdateService
public class LineUpdate: Codable {
    public let lineID: Int64;
    public let donationID: Int64;
    public let unitaryCost: Float;
    public let originalQuantity: Int;
    public let pickUpDate: Date;
    public let productExpiration: Date;
    
    public init (lineID: Int64, donationID: Int64, unitaryCost: Float, originalQuantity: Int, pickUpDate: Date, productExpiration: Date) {
        self.lineID = lineID;
        self.donationID = donationID;
        self.unitaryCost = unitaryCost;
        self.originalQuantity = originalQuantity;
        self.pickUpDate = pickUpDate;
        self.productExpiration = productExpiration;
    }
}
