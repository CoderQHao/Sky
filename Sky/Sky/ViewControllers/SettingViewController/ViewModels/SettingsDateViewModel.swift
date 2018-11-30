//
//  SettingsDateViewModel.swift
//  Sky
//
//  Created by Qing ’s on 2018/11/30.
//  Copyright © 2018 Qing's. All rights reserved.
//

import UIKit

struct SettingsDateViewModel: SettingsRepresentable {
    let dateMode: DateMode
    
    var labelText: String {
        return dateMode == .text ? "Fri, 01 December" : "F, 12/01"
    }
    
    var accessory: UITableViewCell.AccessoryType {
        if UserDefaults.dateMode() == dateMode {
            return .checkmark
        } else {
            return .none
        }
    }
}
