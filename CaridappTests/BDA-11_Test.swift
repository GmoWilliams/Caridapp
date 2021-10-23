//
//  BDA-11_Tests.swift
//  CaridappTests
//
//  Created by user190825 on 10/21/21.
//

import XCTest
@testable import Caridapp
class BDA11Test: XCTestCase {
    
    func testDecodableProduct() throws {
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
    
    // PERFORMANCE TESTS
    /*
    let getLines = LineTableViewController()

       func testRetrieveLines() throws {
           // This is an example of a performance test case.
           self.measure {
               // Put the code you want to measure the time of here.
            getLines.downloadJSON
                   (history) in
               }
           }
       }
    */
    
    // REGRESION TESTS
let registerP = APIRequest(endpoint: "import")

    func testRegisterProduct() throws {
        // Given
        let upcP: Int64 = 345901
        let nameP: String = "Jabon"
        let descP: String = "Jabon de maiz"
        let weightP:Double = 5.0
        
        let datos = Product(upc: upcP, itemName: nameP, description: descP, unitaryWeight: weightP)
        // When
        let postRequest = APIRequest(endpoint: "import")
        postRequest.save(datos, completion: {result in
            switch result{
            case .success(let datos):
                print("Se registro en la Base de Datos exitosamente tu producto:\n Nombre del producto: \(datos.itemName)\n Descripcion: \(datos.description)\n UPC: \(datos.upc)\n Peso: \(datos.unitaryWeight)")
                // Then
                XCTAssert(true)
            
            case .failure(let err):
                print("Ocurrio un error: \(err)")
                // Then
                XCTFail()
            }
            })
        
    }
}
