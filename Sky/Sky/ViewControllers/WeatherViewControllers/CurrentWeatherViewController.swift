//
//  CurrentWeatherViewController.swift
//  Sky
//
//  Created by Qing’s on 2018/3/14.
//  Copyright © 2018年 Qing's. All rights reserved.
//

import UIKit

protocol CurrentWeatherViewControllerDelegate: class {
    func locationButtonPressed(controller: CurrentWeatherViewController)
    func settingsButtonPressed(controlled: CurrentWeatherViewController)
}

class CurrentWeatherViewController: WeatherViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    weak var delegate: CurrentWeatherViewControllerDelegate?
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        delegate?.locationButtonPressed(controller: self)
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        delegate?.settingsButtonPressed(controlled: self)
    }

    var now: WeatherData? {
        didSet {
            DispatchQueue.main.sync {
                self.updateView()
            }
        }
    }
    
    var location: Location? {
        didSet {
            DispatchQueue.main.async {
                self.updateView()
            }
        }
    }
    
    func updateView() {
        activityIndicatorView.stopAnimating()
        
        if let now = now, let location = location {
            updateWeatherContainer(with: now, at: location)
        } else {
            loadingFailedLabel.isHidden = false
            loadingFailedLabel.text = "获取天气/位置失败了"
        }
    }
    
    func updateWeatherContainer(with data: WeatherData, at loaction: Location) {
        weatherContainerView.isHidden = false
        
        // 位置
        locationLabel.text = loaction.name
        
        // 温度
        temperatureLabel.text = String(format: "%.1f ℃", data.currently.temperature.toCelcius())
        
        // 图标
        weatherIcon.image = weatherIcon(of: data.currently.icon)
        
        // 湿度
        humidityLabel.text = String(format: "%.1f", data.currently.humidity)
        
        // 描述
        summaryLabel.text = data.currently.summary
        
        // 时间
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMMM"
        dateLabel.text = formatter.string(from: data.currently.time)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
