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
        
        // When
        
        let app = XCUIApplication()
        app.navigationBars["CARIDAPP"].buttons["SideMenuButton"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Modificar Donacion (BDA-2)"]/*[[".cells.staticTexts[\"Modificar Donacion (BDA-2)\"]",".staticTexts[\"Modificar Donacion (BDA-2)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    
        app.tables["BDA-2 LineTable"].cells.element(boundBy: 0).press(forDuration: 2.0)
        
        app/*@START_MENU_TOKEN@*/.textFields["UnitaryCostTextField"]/*[[".textFields[\"32.0\"]",".textFields[\"UnitaryCostTextField\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let key = app/*@START_MENU_TOKEN@*/.keys["3"]/*[[".keyboards.keys[\"3\"]",".keys[\"3\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key.tap()
        
        let key2 = app/*@START_MENU_TOKEN@*/.keys["2"]/*[[".keyboards.keys[\"2\"]",".keys[\"2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key2.tap()
    
        app.staticTexts["Costo Unitario:"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["CORREGIR"]/*[[".buttons[\"CORREGIR\"].staticTexts[\"CORREGIR\"]",".staticTexts[\"CORREGIR\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts["Corregir Datos"].scrollViews.otherElements.buttons["OK"].tap()
        app.tables["BDA-2 LineTable"].cells.element(boundBy: 0).press(forDuration: 2.0)

        let input = XCUIApplication().textFields["UnitaryCostTextField"].placeholderValue
        XCTAssertEqual(input, "32.0")
        
    }

}
