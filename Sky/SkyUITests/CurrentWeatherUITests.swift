//
//  CurrentWeatherUITests.swift
//  SkyUITests
//
//  Created by Qing’s on 2018/3/14.
//  Copyright © 2018年 Qing's. All rights reserved.
//

import XCTest

class CurrentWeatherUITests: XCTestCase {
    // 正在执行的 App
    let app = XCUIApplication()
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        app.launchArguments += ["UI-TESTING"]
        let json = """
        {
            "longitude" : 100,
            "latitude" : 52,
            "currently" : {
                "temperature" : 23,
                "humidity" : 0.91,
                "icon" : "snow",
                "time" : 1507180335,
                "summary" : "Light Snow"
            }
        }
        """
        app.launchEnvironment["FakeJSON"] = json
        
        app.launch()
    }
    
    override func tearDown() {

        super.tearDown()
    }
    
    func test_location_button_exists() {
        let locationBtn = app.buttons["LocationBtn"]
        XCTAssert(locationBtn.exists)
     }
    
    func test_current_weather_display() {
        XCTAssert(app.images["snow"].exists)
        XCTAssert(app.staticTexts["Light Snow"].exists)
    }
    
}
