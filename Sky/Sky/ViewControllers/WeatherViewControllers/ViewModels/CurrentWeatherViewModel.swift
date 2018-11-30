//
//  CurrentWeatherViewModel.swift
//  Sky
//
//  Created by Qing’s on 2018/3/14.
//  Copyright © 2018年 Qing's. All rights reserved.
//

import UIKit

struct CurrentWeatherViewModel {
    /// 位置信息是否加载完成
    var isLocationReady = false
    /// 天气信息是否加载完成
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
        let value = weather.currently.temperature
        switch UserDefaults.temperatureMode() {
        case .fahrenheit:
            return String(format: "%.1f °F", value)
        case .celsius:
            return String(format: "%.1f °C", value.toCelsius())
        }
    }
    
    // 湿度
    var humidity: String {
        return String(format: "%.1f %%", weather.currently.humidity * 100)
    }
    
    // 描述
    var summary: String {
        return weather.currently.summary
    }
    
    // 时间
    var date: String {
        let formatter = DateFormatter()
        formatter.dateFormat = UserDefaults.dateMode().format
        
        return formatter.string(from: weather.currently.time)
    }
    
}
