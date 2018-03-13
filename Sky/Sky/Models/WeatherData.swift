
//
//  WeatherData.swift
//  Sky
//
//  Created by Qing’s on 2018/3/13.
//  Copyright © 2018年 Qing's. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let latitude: Double
    let longitude: Double
    let currently: CurrentWeather
    
    struct CurrentWeather: Codable {
        let time: Date
        let summary: String
        let icon: String
        let temperature: Double
        let humidity: Double
    }
}
