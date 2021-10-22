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
        let donation = Donation(status: nil, receptionDate: nil, pickUpDate: nil, warehouse: nil)
        donation.addLine(line: Line(upc: 750105530007, cost: 50.50, expirationDate: dateFromatter.date(from: "2021-10-13")!, orQuantity: 6, quantity: 5, name: "CocaC-Cola"))
        
        
        
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
    
    func testGetProducts() throws {
        // When
        let convertExpectation = expectation(description: "Get Products Done")
        donationService.getProducts() {
            (products) in
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
    
    func testDecodableProduct() throws {
        // Given
        let json = """
            [
                {
                    "upc": 1,
                    "itemName": "chocolate Anjelica",
                    "description": "de caf[e",
                    "unitaryWeight": 23
                },
                {
                    "upc": 2,
                    "itemName": "valets ",
                    "description": "desert ",
                    "unitaryWeight": 1
                }
            ]
        """.data(using: .utf8)!
        do {
            // When
            let product = try JSONDecoder().decode([Product].self, from: json)
            
            // Then
            XCTAssertEqual(product[0].upc , 1)
            XCTAssertEqual(product[0].itemName , "chocolate Anjelica")
            XCTAssertEqual(product[0].description , "de caf[e")
            XCTAssertEqual(product[0].unitaryWeight , 23.0)
        } catch {
            XCTFail("error info: \(error)")
        }
    }

}
