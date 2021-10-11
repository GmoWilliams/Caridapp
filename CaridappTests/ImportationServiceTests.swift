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
    
    func testDecodeHistory() throws {
            // Given
            let json = """
                [{
                    "created": "2021-8-29",
                    "original": {
                        "value": 15,
                        "unit": "CELSIUS"
                    },
                    "converted": {
                        "value": 59,
                        "unit": "FAHRENHEIT"
                    }
                }]
            """.data(using: .utf8)!
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            let history = try decoder.decode([Importation].self, from: json)
            
            XCTAssertEqual(history[0].upc, 15)
            XCTAssertEqual(history[0].upc, 59)
        }
    
}//end of class
