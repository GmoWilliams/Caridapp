//
//  CaridappConfirmationUITests.swift
//  CaridappVerificationUITests
//
//  Created by user196197 on 10/25/21.
//

import XCTest

class CaridappConfirmationUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // Use recording to get started writing UI tests.
        
        
        let app = XCUIApplication()
        app.navigationBars["CARIDAPP"].buttons["SideMenuButton"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Verificar Donacion (temporal BDA-14,15)"]/*[[".cells.staticTexts[\"Verificar Donacion (temporal BDA-14,15)\"]",".staticTexts[\"Verificar Donacion (temporal BDA-14,15)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tables["BDA-15 donatTble"].cells.element(boundBy: 0).press(forDuration: 2.0)
        app/*@START_MENU_TOKEN@*/.staticTexts["Listo"]/*[[".buttons[\"Listo\"].staticTexts[\"Listo\"]",".staticTexts[\"Listo\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let app2 = XCUIApplication()
        app2/*@START_MENU_TOKEN@*/.textFields["warehouseTextFieldID"]/*[[".textFields[\"3\"]",".textFields[\"warehouseTextFieldID\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let key = app2/*@START_MENU_TOKEN@*/.keys["2"]/*[[".keyboards.keys[\"2\"]",".keys[\"2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key.tap()
        app2/*@START_MENU_TOKEN@*/.staticTexts["Guardar"]/*[[".buttons[\"Guardar\"].staticTexts[\"Guardar\"]",".staticTexts[\"Guardar\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app2.alerts["Guardar a almacén"].scrollViews.otherElements.buttons["OK"].tap()
        
        
        
        
        
        
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssert(true)
    }

}
