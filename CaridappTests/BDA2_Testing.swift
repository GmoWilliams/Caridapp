//
//  BDA2_Testing.swift
//  CaridappTests
//
//  Created by user190825 on 10/24/21.
//

import XCTest
@testable import Caridapp
class BDA2_Testing: XCTestCase {

    // REGRESION TEST
    func testDecodableLine() throws {
           // Given
           let json = """
               {
                    "lineID": 15,
                    "pickUpDate": "2021-11-03T00:00:00.000Z",
                    "donationID": 165,
                    "unitaryCost": 32.5,
                    "productExpiration": "2021-11-03T00:00:00.000Z",
                    "originalQuantity": 32
               }
           """.data(using: .utf8)!
           do {
                
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                
               // When
            let line = try decoder.decode(LineUpdate.self, from: json)
            
            let pick = "2021-11-03T00:00:00.000Z"
            let pickE = dateFormatter.date(from:pick)!
            let exp = "2021-11-03T00:00:00.000Z"
            let expE = dateFormatter.date(from:exp)!
           
               // Then
            XCTAssertEqual(line.lineID, 15)
            XCTAssertEqual(line.pickUpDate, pickE)
            XCTAssertEqual(line.donationID, 165)
            XCTAssertEqual(line.unitaryCost, 32.5)
            XCTAssertEqual(line.productExpiration, expE)
            XCTAssertEqual(line.originalQuantity, 32)
           } catch {
               XCTFail("error info: \(error)")
           }
       }
    
    // INTEGRATION TESTS
        func testUpdateLine() throws {
            // Given
            let lineIDP: Int64 = 5
            let donaIDP: Int64 = 165
            let uCostP: Float = 32.5
            let quantP:Int = 5
            let pickE: String = "2021-11-03T00:00:00.000Z"
            let expE:String = "2021-11-03T00:00:00.000Z"
            
            let encoder = JSONEncoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            encoder.dateEncodingStrategy = .formatted(dateFormatter)
            let pickP = dateFormatter.date(from:pickE)!
            let expP = dateFormatter.date(from:expE)!
            
            let datos = LineUpdate(lineID: lineIDP, donationID: donaIDP, unitaryCost: uCostP, originalQuantity: quantP, pickUpDate: pickP, productExpiration: expP)
            // When
            let postRequest = APIRequest2(endpoint: "updateLine")
            postRequest.save(datos, completion: {result in
                switch result{
                case .success(let datos):
                    print("Se registro en la Base de Datos exitosamente tu producto:\n ID de la linea: \(datos.lineID)\n Costo Unitario: \(datos.unitaryCost)\n Cantidad: \(datos.originalQuantity)\n Expiracion: \(datos.productExpiration) \n Recoger: \(datos.pickUpDate)")
                    XCTAssert(true)
                    
                case .failure(let err):
                    print("Ocurrio un error: \(err)")
                    // Then
                    XCTFail()
                }
                })
        }
    
    // PERFORMANCE TESTS
    func testEditLinePerformance(){
        self.measure{
            // Given
            let lineIDP: Int64 = 5
            let donaIDP: Int64 = 165
            let uCostP: Float = 32.5
            let quantP:Int = 5
            let pickE: String = "2021-11-03T00:00:00.000Z"
            let expE:String = "2021-11-03T00:00:00.000Z"
            
            let encoder = JSONEncoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            encoder.dateEncodingStrategy = .formatted(dateFormatter)
            let pickP = dateFormatter.date(from:pickE)!
            let expP = dateFormatter.date(from:expE)!
            
            let datos = LineUpdate(lineID: lineIDP, donationID: donaIDP, unitaryCost: uCostP, originalQuantity: quantP, pickUpDate: pickP, productExpiration: expP)
            // When
            let postRequest = APIRequest2(endpoint: "updateLine")
            postRequest.save(datos, completion: {result in
                switch result{
                case .success(let datos):
                    print("Se registro en la Base de Datos exitosamente tu producto:\n ID de la linea: \(datos.lineID)\n Costo Unitario: \(datos.unitaryCost)\n Cantidad: \(datos.originalQuantity)\n Expiracion: \(datos.productExpiration) \n Recoger: \(datos.pickUpDate)")
                    XCTAssert(true)
                    
                case .failure(let err):
                    print("Ocurrio un error: \(err)")
                    // Then
                    XCTFail()
                }
                })
        }
    }
    
}// end of BDA-2 Tests
