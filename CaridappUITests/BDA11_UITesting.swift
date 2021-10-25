//
//  BDA11_UITesting.swift
//  CaridappUITests
//
//  Created by user190825 on 10/23/21.
//

import XCTest

class BDA11_UITesting: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false

        XCUIApplication().launch()
    }

    override func tearDownWithError() throws {
    }

    func testBDA_2() throws {
        
        // NOTE: Since UPC is a value that cannot be repeated let key2 must be changed into the next number for each iteration
        
        // When
        let app = XCUIApplication()
        app/*@START_MENU_TOKEN@*/.staticTexts["Agregar Importacion"]/*[[".buttons[\"Agregar Importacion\"].staticTexts[\"Agregar Importacion\"]",".staticTexts[\"Agregar Importacion\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.textFields["itemName"].tap()
        
        let tKey = app/*@START_MENU_TOKEN@*/.keys["t"]/*[[".keyboards.keys[\"t\"]",".keys[\"t\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        tKey.tap()
        let eKey = app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        eKey.tap()
        let sKey = app/*@START_MENU_TOKEN@*/.keys["s"]/*[[".keyboards.keys[\"s\"]",".keys[\"s\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        sKey.tap()
        tKey.tap()
        
        app.textFields["desc"].tap()
        tKey.tap()
        eKey.tap()
        sKey.tap()
        tKey.tap()
        
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).tap()
        
        app.textFields["upc"].tap()
        
        let key = app/*@START_MENU_TOKEN@*/.keys["1"]/*[[".keyboards.keys[\"1\"]",".keys[\"1\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key.tap()
        
        // THIS KEY
        let key2 = app.keys["4"]
        key2.tap()
        
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).tap()
        
        app.textFields["weight"].tap()
        key.tap()
        let key3 = app/*@START_MENU_TOKEN@*/.keys["."]/*[[".keyboards.keys[\".\"]",".keys[\".\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key3.tap()
        key2.tap()
        
        app/*@START_MENU_TOKEN@*/.staticTexts["REGISTRAR"]/*[[".buttons[\"REGISTRAR\"].staticTexts[\"REGISTRAR\"]",".staticTexts[\"REGISTRAR\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts["Registrar Datos"].scrollViews.otherElements.buttons["OK"].tap()
        app.staticTexts["Costo Unitario:"].tap()
        
        XCTAssert(true)
    }
}
