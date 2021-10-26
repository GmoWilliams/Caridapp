//
//  BDA-11_Tests.swift
//  CaridappTests
//
//  Created by user190825 on 10/21/21.
//
import XCTest
@testable import Caridapp
class BDA11Test: XCTestCase {
    
    // REGRESION TEST
    func testDecodableProduct() throws {
           // Given
           let json = """
               {
                    "upc": 15555,
                    "itemName": "Chocolate abuelita",
                    "description": "Saborizante de vainilla",
                    "unitaryWeight": 12.5
               }
           """.data(using: .utf8)!
           do {
                
                let decoder = JSONDecoder()
                
               // When
            let product = try decoder.decode(Product.self, from: json)
            
            
           
               // Then
            XCTAssertEqual(product.upc, 15555)
            XCTAssertEqual(product.itemName, "Chocolate abuelita")
            XCTAssertEqual(product.description, "Saborizante de vainilla")
            XCTAssertEqual(product.unitaryWeight, 12.5)
           
           } catch {
               XCTFail("error info: \(error)")
           }
       }
    
    // INTEGRATION TESTS
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
    
    // PERFORMANCE TESTS
    func testRegProductPerfromance(){
        self.measure {
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
}// end of BDA-11 Tests
