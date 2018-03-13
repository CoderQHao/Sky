//
//  WeatherDataManager.swift
//  Sky
//
//  Created by Qing’s on 2018/3/13.
//  Copyright © 2018年 Qing's. All rights reserved.
//

import Foundation

enum DataManagerError: Error {
    case failedRequest
    case invalidResponse
    case unknow
}

final class WeatherDataManager {
    private let baseURL: URL
    private init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    static let shared = WeatherDataManager(baseURL: API.authenticatedURL)
    
    typealias CompletionHandler = (WeatherData?, DataManagerError?) -> Void
    
    func weatherDataAt(latitude: Double, longitude: Double, completion: @escaping CompletionHandler) {
        let url = baseURL.appendingPathComponent("\(latitude),\(longitude)")
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { 
            (data, response, error) in
            DispatchQueue.main.async {
                self.didFinishGettingWeatherData(data: data, response: response, error: error, completion: completion)
            }
        }
    }
    
    func didFinishGettingWeatherData(data: Data?, response: URLResponse?, error: Error?, completion: CompletionHandler) {
        if let _ = error {
            completion(nil, .failedRequest)
        } else if let data = data, let response = response as? HTTPURLResponse {
            if response.statusCode == 200 {
                do {
                    let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                    completion(weatherData, nil)
                } catch {
                    completion(nil, .invalidResponse)
                }
            } else {
                completion(nil, .failedRequest)
            }
        } else {
            completion(nil, .unknow)
        }
    }
}
