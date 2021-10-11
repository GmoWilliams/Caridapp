//
//  ImportationServiceTests.swift
//  CaridappTests
//
//  Created by user190825 on 10/9/21.
//

import XCTest
@testable import Caridapp

class ImportationServiceIntegrationTests: XCTestCase {
    func testDecodableEnum() throws {
        // Given
        let json = """
            {
                "name": "donas",
                "desc": "chocolate"
            }
        """.data(using: .utf8)!
        do {
            // When
            let product = try JSONDecoder().decode(Importation.self, from: json)
            
            // Then
            XCTAssertEqual(product.name, "donas")
        } catch {
            XCTFail("error info: \(error)")
        }
    }
    
    
}//end of class
