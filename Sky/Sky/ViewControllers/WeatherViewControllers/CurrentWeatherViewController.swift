//
//  CurrentWeatherViewController.swift
//  Sky
//
//  Created by Qing’s on 2018/3/14.
//  Copyright © 2018年 Qing's. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol CurrentWeatherViewControllerDelegate: class {
    func locationButtonPressed(controller: CurrentWeatherViewController)
    func settingsButtonPressed(controller: CurrentWeatherViewController)
}

class CurrentWeatherViewController: WeatherViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    weak var delegate: CurrentWeatherViewControllerDelegate?
    
    private var bag = DisposeBag()
    
    var weatherVM: BehaviorRelay<CurrentWeatherViewModel> = BehaviorRelay(value: CurrentWeatherViewModel.empty)
    var locationVM: BehaviorRelay<CurrentLocationViewModel> = BehaviorRelay(value: CurrentLocationViewModel.empty)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Observable.combineLatest(locationVM, weatherVM) {
                return ($0, $1)
            }
            .filter {
                let (location, weather) = $0
                return !(location.isEmpty) && !(weather.isEmpty)
        }
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { [unowned self] in
            let (location, weather) = $0
            
            self.activityIndicatorView.stopAnimating()
            self.weatherContainerView.isHidden = false
            
            // 位置
            self.locationLabel.text = location.city
            
            // 温度
            self.temperatureLabel.text = weather.temperature
            
            // 图标
            self.weatherIcon.image = weather.weatherIcon
            
            // 湿度
            self.humidityLabel.text = weather.humidity
            
            // 描述
            self.summaryLabel.text = weather.summary
            
            // 时间
            self.dateLabel.text = weather.date
        }).disposed(by: bag)
    }
    
    func updateView() {
        weatherVM.accept(weatherVM.value)
        locationVM.accept(locationVM.value)
    }
    
    @IBAction func locationButtonPressed(_ sender: UIButton) {
        delegate?.locationButtonPressed(controller: self)
    }
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        delegate?.settingsButtonPressed(controller: self)
    }

}
