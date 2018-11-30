//
//  SettingsTableViewCell.swift
//  Sky
//
//  Created by Qing ’s on 2018/11/30.
//  Copyright © 2018 Qing's. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    static let reuseIdentifier = "SettingsTableViewCell"
    @IBOutlet var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func configure(with vm: SettingsRepresentable) {
        label.text = vm.labelText
        accessoryType = vm.accessory
    }
}
