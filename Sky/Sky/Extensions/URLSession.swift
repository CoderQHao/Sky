//
//  URLSession.swift
//  Sky
//
//  Created by Qing’s on 2018/3/13.
//  Copyright © 2018年 Qing's. All rights reserved.
//

import Foundation

extension URLSession: URLSessionProtocal {
    func dataTask(with request: URLRequest, completionHandler: @escaping dataTaskHandler) -> URLSessionDataTaskProtocal {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTask as URLSessionDataTaskProtocal
    }
}
