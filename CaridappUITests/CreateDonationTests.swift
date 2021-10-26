//
//  CreateDonationTests.swift
//  CaridappUITests
//
//  Created by user194082 on 10/25/21.
//

import XCTest

class CreateDonationTests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false

        XCUIApplication().launch()
    }

    override func tearDownWithError() throws {
    }
    
    func testCreateDonationWithProduct() throws {
        
        let app = XCUIApplication()
        app.buttons["Agregar Importacion"].tap()
        app.textFields["itemName"].tap()
        
        let descTextField = app.textFields["desc"]
        descTextField.tap()
        descTextField.tap()
        descTextField.tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1)
        element.tap()
        
        let upcTextField = app.textFields["upc"]
        upcTextField.tap()
        upcTextField.tap()
        element.tap()
        
        let weightTextField = app.textFields["weight"]
        weightTextField.tap()
        weightTextField.tap()
        element.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["REGISTRAR"]/*[[".buttons[\"REGISTRAR\"].staticTexts[\"REGISTRAR\"]",".staticTexts[\"REGISTRAR\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.alerts["Registrar Datos"].scrollViews.otherElements.buttons["OK"].tap()
        
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .textField).element.tap()
        app.datePickers.otherElements["Date Picker"].tap()
        app/*@START_MENU_TOKEN@*/.datePickers/*[[".otherElements[\"Preview\"].datePickers",".datePickers"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.collectionViews.buttons["Wednesday, October 20"].otherElements.containing(.staticText, identifier:"20").element.tap()
        
        app/*@START_MENU_TOKEN@*/.datePickers/*[[".otherElements[\"Preview\"].datePickers",".datePickers"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["Month"].swipeDown()
        
        let element2 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1)
        element2.children(matching: .other).element.children(matching: .other).element(boundBy: 2).children(matching: .textField).element.tap()
        element2.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["AGREGAR"]/*[[".buttons[\"AGREGAR\"].staticTexts[\"AGREGAR\"]",".staticTexts[\"AGREGAR\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Terminar Importacion"]/*[[".buttons[\"Terminar Importacion\"].staticTexts[\"Terminar Importacion\"]",".staticTexts[\"Terminar Importacion\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssert(true)
        
    }
    
    func testCreateDonationWithCommonProducts() throws {
        
        let app = XCUIApplication()
        app/*@START_MENU_TOKEN@*/.staticTexts["Agregar Importacion"]/*[[".buttons[\"Agregar Importacion\"].staticTexts[\"Agregar Importacion\"]",".staticTexts[\"Agregar Importacion\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Productos mas recurrentes"].tap()
        
        app.tables.element(boundBy: 0).cells.element(boundBy: 0).tap()
        
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .textField).element.tap()
        app.datePickers.otherElements["Date Picker"].tap()
        app.datePickers.collectionViews.buttons["Wednesday, October 20"].otherElements.containing(.staticText, identifier:"20").element.tap()
        
        app.datePickers.buttons["Month"].swipeDown()
        
        let element2 = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1)
        element2.children(matching: .other).element.children(matching: .other).element(boundBy: 2).children(matching: .textField).element.tap()
        element2.tap()
        app.staticTexts["AGREGAR"].tap()
        app.staticTexts["Terminar Importacion"].tap()
        XCTAssert(true)
        
    }

}
