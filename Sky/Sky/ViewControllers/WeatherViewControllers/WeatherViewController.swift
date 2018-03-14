//
//  WeatherViewController.swift
//  Sky
//
//  Created by Qing’s on 2018/3/14.
//  Copyright © 2018年 Qing's. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var weatherContainerView: UIView!
    @IBOutlet weak var loadingFailedLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    func weatherIcon(of name: String) -> UIImage? {
        switch name {
        case "clear-day":
            return UIImage(named: "clear-day")
        case "clear-night":
            return UIImage(named: "clear-night")
        case "rain":
            return UIImage(named: "rain")
        case "snow":
            return UIImage(named: "snow")
        case "sleet":
            return UIImage(named: "sleet")
        case "wind":
            return UIImage(named: "wind")
        case "cloudy":
            return UIImage(named: "cloudy")
        case "partly-cloudy-day":
            return UIImage(named: "partly-cloudy-day")
        case "partly-cloudy-night":
            return UIImage(named: "partly-cloudy-night")
        default:
            return UIImage(named: "clear-day")
        }
    }
    
    private func setupView() {
        weatherContainerView.isHidden = true
        loadingFailedLabel.isHidden = true
        
        activityIndicatorView.stopAnimating()
        activityIndicatorView.hidesWhenStopped = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }

}





















