//
//  Donation.swift
//  Caridapp
//
//  Created by user190825 on 10/5/21.
//

import Foundation
//import CoreData

//@objc(Importation)
public class Importation: Codable{
    
    public var name: String
    public let desc: String
    public let upc: Int64
    public let weight: Double
    
    //public let picture: String?
    
    public init (name: String, desc: String, upc: Int64, weight: Double){
        self.name = name
        self.desc = desc
        self.upc = upc
        self.weight = weight
        //self.picture = picture
    }
}
