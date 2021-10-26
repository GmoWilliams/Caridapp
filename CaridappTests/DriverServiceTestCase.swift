//
//  DriverServiceTestCase.swift
//  CaridappTests
//
//  Created by user194082 on 10/22/21.
//

import XCTest
@testable import Caridapp
class DriverServiceTestCase: XCTestCase {
    
    let driverService = DriverService()

    func testGetDonations() throws {
        // When
        let convertExpectation = expectation(description: "Get Donations Done!")
        driverService.getDonations() {
            (donations) in
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
    
    func testUpdateDonationStatus() throws {
        // Given
        let donation = DonationDriver(id: 15, name: "name", address: "address")
        
        // When
        let convertExpectation = expectation(description: "Update Status Done!")
        driverService.updateDonationStatus(donation: donation) {
            () in
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
