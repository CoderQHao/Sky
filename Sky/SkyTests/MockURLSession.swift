//
//  MockURLSession.swift
//  SkyTests
//
//  Created by Qing’s on 2018/3/13.
//  Copyright © 2018年 Qing's. All rights reserved.
//

import Foundation
@testable import Sky

class MockURLSession: URLSessionProtocal {
    var responseData: Data?
    var responseHeader: HTTPURLResponse?
    var responseError: Error?
    var sessionDataTask = MockURLSessionDataTask()
    
    func dataTask(with request: URLRequest, completionHandler: @escaping URLSessionProtocal.dataTaskHandler) -> URLSessionDataTaskProtocal {
        completionHandler(responseData, responseHeader, responseError)
        return sessionDataTask
    }
}
