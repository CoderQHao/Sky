//
//  SettingsTemperatureViewModel.swift
//  Sky
//
//  Created by Qing ’s on 2018/11/30.
//  Copyright © 2018 Qing's. All rights reserved.
//

import UIKit

struct SettingsTemperatureViewModel: SettingsRepresentable {
    let temperatureMode: TemperatureMode
    
    var labelText: String {
        return temperatureMode == .celsius ? "Celsius" : "Fahrenheit"
    }
    
    var accessory: UITableViewCell.AccessoryType {
        if UserDefaults.temperatureMode() == temperatureMode {
            return .checkmark
        } else {
            return .none
        }
    }
}
