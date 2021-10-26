//
//  CaridappConfirmationTests.swift
//  CaridappVerificationTests
//
//  Created by user196197 on 10/25/21.
//

import XCTest
@testable import Caridapp

class CaridappConfirmationTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDecodeDonation() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let json = """
            {
                 "donationID": 165,
                 "warehouse": 1
            }
        """.data(using: .utf8)!
        do {
             
             let decoder = JSONDecoder()
             let dateFormatter = DateFormatter()
             decoder.dateDecodingStrategy = .formatted(dateFormatter)
             
            // When
         let line = try decoder.decode(DonationVerification.self, from: json)
        
            // Then
         XCTAssertEqual(line.warehouse, 1)
         XCTAssertEqual(line.donationID, 165)
        } catch {
            XCTFail("error info: \(error)")
        }
    }
    
    func testUpdateLine() throws {
        // Given
        let donationIDPV: Int64 = 15
        
        let warehouse: Int = 2

        let datos = DonationVerification(donationID: donationIDPV, warehouse: warehouse)
        
        let postRequest = APIRequest4(endpoint: "verifyDonation")
        postRequest.save(datos, completion: {result in
            switch result{
            case .success(let datos):
                print("Se registro en la Base de Datos exitosamente tu producto:\n ID de la donacion: \(datos.donationID)\n Almacen: \(datos.warehouse)")
                XCTAssert(true)

            case .failure(let err):
                XCTFail("Ocurrio un error: \(err)")
            }
            })

    }

    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            let donationIDPV: Int64 = 15
            
            let warehouse: Int = 2

            let datos = DonationVerification(donationID: donationIDPV, warehouse: warehouse)
            
            let postRequest = APIRequest4(endpoint: "verifyDonation")
            postRequest.save(datos, completion: {result in
                switch result{
                case .success(let datos):
                    print("Se registro en la Base de Datos exitosamente tu producto:\n ID de la donacion: \(datos.donationID)\n Almacen: \(datos.warehouse)")
                    XCTAssert(true)

                case .failure(let err):
                    XCTFail("Ocurrio un error: \(err)")
                }
                })
        }
    }

}
