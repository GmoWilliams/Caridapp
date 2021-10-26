//
//  CaridappVerificationTests.swift
//  CaridappVerificationTests
//
//  Created by user196197 on 10/23/21.
//

import XCTest

@testable import Caridapp

class CaridappVerificationTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    // Regression test
    func testDecodeLineVeriication() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let json = """
            {
                 "lineID": 15,
                 "donationID": 165,
                 "productExpiration": "2021-11-03T00:00:00.000Z",
                 "quantity": 32
            }
        """.data(using: .utf8)!
        do {
             
             let decoder = JSONDecoder()
             let dateFormatter = DateFormatter()
             dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
             decoder.dateDecodingStrategy = .formatted(dateFormatter)
             
            // When
         let line = try decoder.decode(LineVerification.self, from: json)
        
         let exp = "2021-11-03T00:00:00.000Z"
         let expE = dateFormatter.date(from:exp)!
        
            // Then
         XCTAssertEqual(line.lineID, 15)
         XCTAssertEqual(line.donationID, 165)
         XCTAssertEqual(line.productExpiration, expE)
         XCTAssertEqual(line.quantity, 32)
        } catch {
            XCTFail("error info: \(error)")
        }
    }//End of test

    
    func testverification() throws {
        let lineIDPV: Int64 = 5
        let donationIDPV: Int64 = 15
        let quantP:Int = 10
        let expE:String = "2021-11-03T00:00:00.000Z"
        
        let encoder = JSONEncoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        let expP = dateFormatter.date(from:expE)!
        
        let datos = LineVerification(donationID: donationIDPV, lineID: lineIDPV, productExpiration: expP , quantity: quantP)
        
        let postRequest = APIRequest3(endpoint: "verifyLine")
        postRequest.save(datos, completion: {result in
            switch result{
            case .success(let datos):
                print("Se registro en la Base de Datos exitosamente tu producto:\n ID de la linea: \(datos.lineID)\n Cantidad: \(datos.quantity)")

                XCTAssert(true)

            case .failure(let err):
                XCTFail("Ocurrio un error: \(err)")
            }
        })
    }
    
    
    //Performance tests
    func testPerformanceIntegrationTest() throws {
        // This is an example of a performance test case.
        
        self.measure{
            // Given
            let lineIDPV: Int64 = 5
            let donationIDPV: Int64 = 15
            let quantP:Int = 10
            let expE:String = "2021-11-03T00:00:00.000Z"
            
            let encoder = JSONEncoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            encoder.dateEncodingStrategy = .formatted(dateFormatter)
            let expP = dateFormatter.date(from:expE)!
            
            let datos = LineVerification(donationID: donationIDPV, lineID: lineIDPV, productExpiration: expP , quantity: quantP)
            
            let postRequest = APIRequest3(endpoint: "verifyLine")
            postRequest.save(datos, completion: {result in
                switch result{
                case .success(let datos):
                    print("Se registro en la Base de Datos exitosamente tu producto:\n ID de la linea: \(datos.lineID)\n Cantidad: \(datos.quantity)")

                    XCTAssert(true)

                case .failure(let err):
                    XCTFail("Ocurrio un error: \(err)")
                }
            })
        }
    }//End of test
        
    func testPerformanceRegressionTest() throws {
        // This is an example of a performance test case.
        self.measure {
            let json = """
                {
                     "lineID": 15,
                     "donationID": 165,
                     "productExpiration": "2021-11-03T00:00:00.000Z",
                     "quantity": 32
                }
            """.data(using: .utf8)!
            do {
                 
                 let decoder = JSONDecoder()
                 let dateFormatter = DateFormatter()
                 dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                 decoder.dateDecodingStrategy = .formatted(dateFormatter)
                 
                // When
             let line = try decoder.decode(LineVerification.self, from: json)
            
             let exp = "2021-11-03T00:00:00.000Z"
             let expE = dateFormatter.date(from:exp)!
            
                // Then
             XCTAssertEqual(line.lineID, 15)
             XCTAssertEqual(line.donationID, 165)
             XCTAssertEqual(line.productExpiration, expE)
             XCTAssertEqual(line.quantity, 32)
            } catch {
                XCTFail("error info: \(error)")
            }
        }
    }//End of test

}//End of class
