//
//  CaridappVerificationUITests.swift
//  CaridappVerificationUITests
//
//  Created by user196197 on 10/25/21.
//

import XCTest

class CaridappVerificationUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        
        let app = XCUIApplication()
        app.launch()
 
        app.navigationBars["CARIDAPP"].buttons["SideMenuButton"].tap()
        
        let app2 = XCUIApplication()
        app2.tables/*@START_MENU_TOKEN@*/.staticTexts["Verificar Donacion (temporal BDA-14,15)"]/*[[".cells.staticTexts[\"Verificar Donacion (temporal BDA-14,15)\"]",".staticTexts[\"Verificar Donacion (temporal BDA-14,15)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app2.tables["BDA-15 donatTble"].cells.element(boundBy: 0).press(forDuration: 2.0)
        app2.tables["BDA-14 verifTble"].cells.element(boundBy: 0).press(forDuration: 2.0)
        app2/*@START_MENU_TOKEN@*/.textFields["quantityTextFieldID"]/*[[".textFields[\"2\"]",".textFields[\"quantityTextFieldID\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        

        
        let key = app2/*@START_MENU_TOKEN@*/.keys["4"]/*[[".keyboards.keys[\"4\"]",".keys[\"4\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key.tap()

        app2.buttons["OK"].tap()
        app2.alerts["Corregir Datos"].scrollViews.otherElements.buttons["OK"].tap()

        
                
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssert(true)
    }

}
