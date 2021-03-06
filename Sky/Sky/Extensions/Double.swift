//
//  Double.swift
//  Sky
//
//  Created by Qing’s on 2018/3/14.
//  Copyright © 2018年 Qing's. All rights reserved.
//

import Foundation

extension Double {
    /// 华氏度 -> 摄氏度
    func toCelsius() -> Double {
        return (self - 32.0) / 1.8
    }
}
