//
//  Configuration.swift
//  Sky
//
//  Created by Qing’s on 2018/3/13.
//  Copyright © 2018年 Qing's. All rights reserved.
//

import Foundation

struct API {
    static let key = "28e8cff7ee443b69a45917a1e775590a"
    static let baseURL = URL(string: "https://api.darksky.net/forecast")!
    static let authenticatedURL = baseURL.appendingPathComponent(key)
}
