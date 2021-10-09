//
//  CaridappTests.swift
//  CaridappTests
//
//  Created by user190825 on 9/9/21.
//

import XCTest
@testable import Caridapp

class CaridappTests: XCTestCase {

    func testCreateDonationWithProducts() throws {
        // Given
        let dateFromatter = DateFormatter()
        dateFromatter.dateFormat = "yyyy-MM-dd"
        let donation = Donation(status: nil, receptionDate: nil, pickUpDate: nil, warehouse: nil)
        donation.addProduct(product: Product(itemName: "Coca-Cola", description: "Coca-Cola", weight: 2.5, cost: 50.50, expirationDate: dateFromatter.date(from: "2021-10-13")!, orQuantity: 6, quantity: 5))
        
    }

}
