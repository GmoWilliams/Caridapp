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
    //public let id: Int32!
    public var name: String
    public let desc: String
    //public let deletedDate: Date?
    public init (name: String, desc: String){
        self.name = name
        self.desc = desc
    }
}
