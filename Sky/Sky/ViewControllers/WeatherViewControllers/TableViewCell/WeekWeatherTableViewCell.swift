//
//  WeekWeatherTableViewCell.swift
//  Sky
//
//  Created by Qing ’s on 2018/11/30.
//  Copyright © 2018 Qing's. All rights reserved.
//

import UIKit

class WeekWeatherTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "WeekWeatherCell"
    
    @IBOutlet weak var week: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var humidity: UILabel!

    func configure(with vm: WeekWeatherDayRepresentable) {
        week.text = vm.week
        date.text = vm.date
        humidity.text = vm.humidity
        temperature.text = vm.temperature
        weatherIcon.image = vm.weatherIcon
    }
}
