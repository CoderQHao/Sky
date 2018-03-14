//
//  WeatherDataManagerTest.swift
//  SkyTests
//
//  Created by Qing’s on 2018/3/13.
//  Copyright © 2018年 Qing's. All rights reserved.
//

import XCTest
@testable import Sky

class WeatherDataManagerTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    func test_weatherDataAt_starts_the_session() {
        let session = MockURLSession()
        let dataTask = MockURLSessionDataTask()
     
        session.sessionDataTask = dataTask
        
        let manager = WeatherDataManager(baseURL: URL(string: "https//darksky.net")!, urlSession: session)
        
        manager.weatherDataAt(latitude: 52, longitude: 100) { (_, _) in }
        
        XCTAssert(session.sessionDataTask.isResumeCalled)
    }
    
    func test_weatherDataAt_gets_data() {
        let expect = expectation(description: "Loading data from \(API.authenticatedURL)")
        var data: WeatherData? = nil
        
        WeatherDataManager.shared.weatherDataAt(latitude: 52, longitude: 100) { (response, error) in
            data = response
            expect.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertNotNil(data)
    }
    
    func test_weatherData_handle_invalid_request() {
        let session = MockURLSession()
        session.responseError = NSError(domain: "Invalid Request", code: 100, userInfo: nil)
        
        let manager = WeatherDataManager(baseURL: URL(string: "https://darksky.net")!, urlSession: session)
        
        var error: DataManagerError? = nil
        manager.weatherDataAt(latitude: 52, longitude: 100) { (_, e) in
            error = e
        }
        
        XCTAssertEqual(error, DataManagerError.failedRequest)
    }
    
    func test_weatherData_handle_statuscode_not_equal_to_200() {
        let session = MockURLSession()
        session.responseHeader = HTTPURLResponse(url: URL(string: "https://darksky.net")!, statusCode: 400, httpVersion: nil, headerFields: nil)
        
        let data = "{}".data(using: .utf8)!
        session.responseData = data
        
        let manager = WeatherDataManager(baseURL: URL(string: "https://darksky.net")!, urlSession: session)
        
        var error: DataManagerError? = nil
        
        manager.weatherDataAt(latitude: 52, longitude: 100) { (_, e) in
            error = e
        }
        
        XCTAssertEqual(error, DataManagerError.failedRequest)
    }
    
    func test_weatherDataAt_handle_invalid_response() {
        let session = MockURLSession()
        session.responseHeader = HTTPURLResponse(url: URL(string: "https://darksky.net")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let data = "{".data(using: .utf8)!
        session.responseData = data
        
        let manager = WeatherDataManager(baseURL: URL(string: "https://darksky.net")!, urlSession: session)
        
        var error: DataManagerError? = nil
        
        manager.weatherDataAt(latitude: 52, longitude: 100) { (_, e) in
            error = e
        }
        
        XCTAssertEqual(error, DataManagerError.invalidResponse)
    }
    
    func test_weatherData_handle_response_decode() {
        let session = MockURLSession()
        session.responseHeader = HTTPURLResponse(
            url: URL(string: "https://darksky.net")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil)
        
        let data = """
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
        """.data(using: .utf8)!
        session.responseData = data
        
        var decoded: WeatherData? = nil
        
        let manager = WeatherDataManager(baseURL: URL(string: "https://darksky.net")!, urlSession: session)
        
        manager.weatherDataAt(latitude: 52, longitude: 100) { (d, _) in
            decoded = d
        }
        
        let expected = WeatherData(
            latitude: 52,
            longitude: 100,
            currently: WeatherData.CurrentWeather(
                time: Date(timeIntervalSince1970: 1507180335),
                summary: "Light Snow",
                icon: "snow",
                temperature: 23,
                humidity: 0.91))
        
        XCTAssertEqual(decoded, expected)
    }
    
}





































