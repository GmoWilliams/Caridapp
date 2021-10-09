//
//  Donation+CoreDataProperties.swift
//  Caridapp
//
//  Created by user190825 on 10/4/21.
//
//

import Foundation
import CoreData


extension Donation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Donation> {
        return NSFetchRequest<Donation>(entityName: "Donation")
    }

    @NSManaged public var name: String?
    @NSManaged public var weight: Int16

}

extension Donation : Identifiable {

}
