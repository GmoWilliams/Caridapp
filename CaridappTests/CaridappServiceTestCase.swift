//
//  CaridappServiceTestCase.swift
//  CaridappTests
//
//  Created by user194082 on 10/9/21.
//

import XCTest

class CaridappServiceTestCase: XCTestCase {
    let donationService = DonationService()

    func testPublishDonationWithProducts() throws {
        // Given
        let dateFromatter = DateFormatter()
        dateFromatter.dateFormat = "yyyy-MM-dd"
        let donation = Donation(status: 0, receptionDate: dateFromatter.date(from: "2021-10-01"), pickUpDate: dateFromatter.date(from: "2021-10-01"), warehouse: 2)
        donation.addProduct(product: Product(itemName: "Coca-Cola", description: "Coca-Cola", weight: 2.5, cost: 50.50, expirationDate: dateFromatter.date(from: "2021-10-13")!, orQuantity: 6, quantity: 5))
        
        
        
        // When
        let convertExpectation = expectation(description: "Publish Done")
        donationService.publishDonation(donation: donation) {
            (responseData) in
            convertExpectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 10) {
            (error) in

            if let error = error {
                XCTFail("waitForExpectations errored: \(error)")
            } else {
                XCTAssert(true)
            }
        }
    }

}
