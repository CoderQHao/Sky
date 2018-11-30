//
//  ContentRepresentable.swift
//  Sky
//
//  Created by Qing ’s on 2018/11/30.
//  Copyright © 2018 Qing's. All rights reserved.
//
import UIKit

protocol SettingsRepresentable {
    var labelText: String { get }
    var accessory: UITableViewCell.AccessoryType { get }
}
