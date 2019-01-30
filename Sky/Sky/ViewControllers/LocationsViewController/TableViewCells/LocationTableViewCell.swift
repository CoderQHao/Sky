//
//  LocationTableViewCell.swift
//  Sky
//
//  Created by Qing ’s on 2018/11/30.
//  Copyright © 2018 Qing's. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "LocationCell"
    @IBOutlet weak var label: UILabel!
    
    func configure(with viewModel: LocationRepresentable) {
        label.text = viewModel.labelText
    }
}
