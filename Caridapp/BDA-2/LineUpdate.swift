//
//  LineUpdate.swift
//  Caridapp
//
//  Created by user190825 on 10/18/21.
//

import Foundation

public class LineUpdate: Codable {
    public let lineID: Int64;
    public let unitaryCost: Float;
    //public let expirationDate: Date;
    public let originalQuantity: Int;
    //public let picKUpDate: Date;
    
    public init (lineID: Int64, unitaryCost: Float, originalQuantity: Int) {
        self.lineID = lineID;
        self.unitaryCost = unitaryCost;
        self.originalQuantity = originalQuantity;
    }
}
