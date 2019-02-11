//
//  ViewController.swift
//  Sky
//
//  Created by Qing’s on 2018/3/13.
//  Copyright © 2018年 Qing's. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import CoreLocation

class RootViewController: UIViewController {
    
    private let segueCurrentWeather = "SegueCurrentWeather"
    private let segueWeekWeather = "SegueWeekWeather"
    private let segueSettings = "SegueSettings"
    private let segueLocations = "SegueLocations"
    private var bag = DisposeBag()
    
    var currentWeatherViewController: CurrentWeatherViewController!
    var weekWeatherViewController: WeekWeatherViewController!
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.distanceFilter = 1000
        manager.desiredAccuracy = 1000
        return manager
    }()
    
    // 存储用户的位置
    private var currentLocation: CLLocation? {
        didSet {
            // 根据用户位置设置城市名称
            fetchCity()
            // 获取当地的天气数据
            fetchWeather()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // App 进入活跃状态通知
        setupActiveNotification()
    }
    
    @IBAction func unwindToRootViewController(segue: UIStoryboardSegue) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case segueCurrentWeather:
            guard let destination = segue.destination as? CurrentWeatherViewController else {
                fatalError("目标控制器不存在")
            }
            destination.delegate = self
            currentWeatherViewController = destination
        case segueWeekWeather:
            guard let destination = segue.destination as? WeekWeatherViewController else {
                fatalError("目标控制器不存在")
            }
            weekWeatherViewController = destination
        case segueSettings:
            guard let navigationController = segue.destination as? UINavigationController else {
                fatalError("目标控制器不存在")
            }
            
            guard let destination = navigationController.topViewController as? SettingsViewController else {
                fatalError("目标控制器不存在")
            }
            
            destination.delegate = self
        case segueLocations:
            guard let navigationController = segue.destination as? UINavigationController else {
                fatalError("目标控制器不存在")
            }
            
            guard let destination = navigationController.topViewController as? LocationsViewController else {
                fatalError("目标控制器不存在")
            }
            
            destination.delegate = self
            destination.currentLocation = currentLocation
        default:
           break
        }
    }
    
    /// App 进入活跃状态通知
    func setupActiveNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(RootViewController.applicationDidBecomeAction(_:)), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    // 接收到通知
    @objc func applicationDidBecomeAction(_ notification: Notification) {
        // 请求用户位置
        requestLocation()
    }
    
    /// 请求用户位置
    private func requestLocation() {
        locationManager.delegate = self
        // 获取到了用户授权
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.requestLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    /// 获取当地的天气数据
    private func fetchWeather() {
        guard let currentLocation = currentLocation else { return }
        
        let lat = currentLocation.coordinate.latitude
        let lon = currentLocation.coordinate.longitude
        
        WeatherDataManager.shared.weatherDataAt(latitude: lat, longitude: lon)
            .subscribe(onNext: {
                self.currentWeatherViewController.weatherVM.accept(CurrentWeatherViewModel(weather: $0))
                self.weekWeatherViewController.viewModel = WeekWeatherViewModel(weatherData: $0.daily.data)
            })
            .disposed(by: bag)
    }
    
    /// 根据用户位置设置城市名称
    private func fetchCity() {
        guard let currentLocation = currentLocation else { return }
        
        CLGeocoder().reverseGeocodeLocation(currentLocation) { (placemarks, error) in
            if let error = error {
                dump(error)
            } else {
                if let city = placemarks?.first?.locality {
                    // 读到了位置信息 通知 currentWeatherViewController
                    let location = Location(name: city, latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
                    self.currentWeatherViewController.locationVM.accept(CurrentLocationViewModel(location: location))
                }
            }
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension RootViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 获取到了用户位置
        if let location = locations.first {
            // 保存位置
            currentLocation = location
            manager.delegate = nil
            // 停止更新位置
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


// MARK: - CurrentWeatherViewControllerDelegate
extension RootViewController: CurrentWeatherViewControllerDelegate {
    func locationButtonPressed(controller: CurrentWeatherViewController) {
         performSegue(withIdentifier: segueLocations, sender: self)
    }
    
    func settingsButtonPressed(controller: CurrentWeatherViewController) {
        performSegue(withIdentifier: segueSettings, sender: self)
    }
}

// MARK: - SettingsViewControllerDelegate
extension RootViewController: SettingsViewControllerDelegate {
    private func reloadUI() {
        currentWeatherViewController.updateView()
        weekWeatherViewController.updateView()
    }
    
    func controllerDidChangeTimeMode(controller: SettingsViewController) {
        reloadUI()
    }
    
    func controllerDidChangeTemperatureMode(controller: SettingsViewController) {
        reloadUI()
    }
}

// MARK: - LocationsViewControllerDelegate
extension RootViewController: LocationsViewControllerDelegate {
    func controller(_ controller: LocationsViewController, didSelectLocation location: CLLocation) {
        currentLocation = location
    }
}


















