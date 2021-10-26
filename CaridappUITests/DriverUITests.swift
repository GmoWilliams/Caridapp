//
//  DriverUITests.swift
//  CaridappUITests
//
//  Created by user194082 on 10/25/21.
//

import XCTest

class DriverUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false

        XCUIApplication().launch()

    }

    override func tearDownWithError() throws {
        
    }

    func testCheckDonation() throws {
        
        let app = XCUIApplication()
        app.navigationBars["CARIDAPP"].buttons["SideMenuButton"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Recepcion de carga / chofer (temporal BDA-13)"]/*[[".cells.staticTexts[\"Recepcion de carga \/ chofer (temporal BDA-13)\"]",".staticTexts[\"Recepcion de carga \/ chofer (temporal BDA-13)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        if(app.tables.element(boundBy: 0).cells.count > 0){
            app.tables.element(boundBy: 0).cells.element(boundBy: 0).tap()
        }
        
    }

}
