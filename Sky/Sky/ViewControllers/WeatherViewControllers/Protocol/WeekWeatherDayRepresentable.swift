//
//  WeekWeatherDayRepresentable.swift
//  Sky
//
//  Created by Qing ’s on 2018/11/30.
//  Copyright © 2018 Qing's. All rights reserved.
//

import UIKit

protocol WeekWeatherDayRepresentable {
    var week: String { get }
    var date: String { get }
    var temperature: String { get }
    var weatherIcon: UIImage? { get }
    var humidity: String { get }
}

