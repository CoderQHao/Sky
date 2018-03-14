//
//  CurrentWeatherViewModel.swift
//  Sky
//
//  Created by Qing’s on 2018/3/14.
//  Copyright © 2018年 Qing's. All rights reserved.
//

import UIKit

struct CurrentWeatherViewModel {
    
    var isLocationReady = false
    var isWeatherReady = false
    
    var isUpdateReady: Bool {
        return isLocationReady && isWeatherReady
    }
    
    var location: Location! {
        didSet {
            self.isLocationReady = location != nil
        }
    }
    
    var weather: WeatherData! {
        didSet {
            self.isWeatherReady = weather != nil
        }
    }
    
    // 位置
    var city: String {
        return location.name
    }
    
    // 图标
    var weatherIcon: UIImage {
        return UIImage.weatherIcon(of: weather.currently.icon)!
    }
    
    // 温度
    var temperature: String {
        return String(format: "%.1f ℃", weather.currently.temperature.toCelcius())
    }
    
    // 湿度
    var humidity: String {
        return String(format: "%.1f", weather.currently.humidity)
    }
    
    // 描述
    var summary: String {
        return weather.currently.summary
    }
    
    // 时间
    var date: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMMM"
        return formatter.string(from: weather.currently.time)
    }
    
}
