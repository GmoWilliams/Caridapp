//
//  Donation.swift
//  Caridapp
//
//  Created by user194082 on 9/29/21.
//

import Foundation

public class Donation: Codable {
    public var lineArray = [Line]();
    public var status: Int?;
    public var receptionDate: Date?;
    public var pickUpDate: Date?;
    public var warehouse: Int?;
    
    public init (status: Int?, receptionDate: Date?, pickUpDate: Date?, warehouse: Int?){
        self.status = status;
        self.receptionDate = receptionDate;
        self.pickUpDate = pickUpDate;
        self.warehouse = warehouse;
    }
    
    public func addLine (line: Line) {
        self.lineArray.append(line);
    }
}
