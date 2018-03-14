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





















