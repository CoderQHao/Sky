//
//  ViewController.swift
//  Sky
//
//  Created by Qing’s on 2018/3/13.
//  Copyright © 2018年 Qing's. All rights reserved.
//

import UIKit
import CoreLocation

class RootViewController: UIViewController {
    
    var currentWeatherViewController: CurrentWeatherViewController!
    var weekWeatherViewController: WeekWeatherViewController!
    private let segueCurrentWeather = "SegueCurrentWeather"
    private let segueWeekWeather = "SegueWeekWeather"
    private let segueSettings = "SegueSettings"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case segueCurrentWeather:
            guard let destination = segue.destination as? CurrentWeatherViewController else {
                fatalError("目标控制器不存在")
            }
            destination.delegate = self
            destination.viewModel = CurrentWeatherViewModel()
            currentWeatherViewController = destination
        case segueWeekWeather:
            guard let destination = segue.destination as? WeekWeatherViewController else {
                fatalError("目标控制器不存在")
            }
            weekWeatherViewController = destination
        default:
           break
        }
    }
    
    // 存储用户的位置
    private var currentLocation: CLLocation? {
        didSet {
            // 根据用户位置设置城市名称
            fetchCity()
            // 获取当地的天气数据
            fetchWeather()
        }
    }
    
    /// 获取当地的天气数据
    private func fetchWeather() {
        guard let currentLocation = currentLocation else { return }
        
        let lat = currentLocation.coordinate.latitude
        let lon = currentLocation.coordinate.longitude
        
        WeatherDataManager.shared.weatherDataAt(latitude: lat, longitude: lon) { (response, error) in
            if let error = error {
                dump(error)
            } else {
                if let response = response {
                    // 通知当前天气控制器
                    self.currentWeatherViewController.viewModel?.weather = response
                    self.weekWeatherViewController.viewModel = WeekWeatherViewModel(weatherData: response.daily.data)
                }
            }
        }
    }
    
    /// 根据用户位置设置城市名称
    private func fetchCity() {
        guard let currentLocation = currentLocation else { return }
        
        CLGeocoder().reverseGeocodeLocation(currentLocation) { (placemarks, error) in
            if let error = error {
                dump(error)
            } else {
                if let city = placemarks?.first?.locality {
                    // 读到了位置信息 通知当前天气控制器
                    let l = Location(name: city, latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
                    self.currentWeatherViewController.viewModel?.location = l
                }
            }
        }
    }
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.distanceFilter = 1000
        manager.desiredAccuracy = 1000
        return manager
    }()
    
    private func requestLocation() {
        locationManager.delegate = self
        // 获取到了用户授权
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.requestLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupActiveNotification()
    }
    
    // 接收到通知
    @objc func applicationDidBecomeAction(notification: Notification) {
        // 请求用户位置
        requestLocation()
    }
    
    // App 进入活跃状态通知
    func setupActiveNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(RootViewController.applicationDidBecomeAction(notification:)), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
}

extension RootViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 获取到了用户位置
        if let location = locations.first {
            // 保存位置
            currentLocation = location
            manager.delegate = nil
            manager.stopUpdatingLocation()
        }
    }
    
    // 用户改变了授权
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.requestLocation()
        }
    }
    
    // 定位功能发生错误
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        dump(error)
    }
}

extension RootViewController: CurrentWeatherViewControllerDelegate {
    func locationButtonPressed(controller: CurrentWeatherViewController) {
        
    }
    
    func settingsButtonPressed(controller: CurrentWeatherViewController) {
        
    }
}






















