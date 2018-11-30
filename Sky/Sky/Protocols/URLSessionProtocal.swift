//
//  URLSessionProtocal.swift
//  Sky
//
//  Created by Qing’s on 2018/3/13.
//  Copyright © 2018年 Qing's. All rights reserved.
//

import Foundation

typealias dataTaskHandler = (Data?, URLResponse?, Error?) -> Void

protocol URLSessionProtocal {
    
    func dataTask(with request: URLRequest, completionHandler: @escaping dataTaskHandler) -> URLSessionDataTaskProtocal
}
