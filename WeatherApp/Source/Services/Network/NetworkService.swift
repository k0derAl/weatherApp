//
//  NetworkService.swift
//  101group
//
//  Created by Max Petrenko on 29.11.17.
//  Copyright © 2017 101 GROUP. All rights reserved.
//
import Alamofire
import Foundation

protocol NetworkServiceProtocol {
    func getDataOfCity(city: String, completion: @escaping (WeatherDataResponce?, Error?) -> Void)

}

class NetworkServiceImp: NetworkServiceProtocol {
    private var manager = SessionManager()

    init() {

    }
    public func getDataOfCity(
        city: String,
        completion: @escaping (WeatherDataResponce?, Error?) -> Void
    ) {
        let data = [
            "q": city,
            "cnt": 24,
            "units": "metric",
            "appid": SittintWeatherOfCityNetRouter.apiKey
        ] as [String : Any]
        let routing = WeatherOfCityNetRouter.getCityData(data)
        self.manager.upload(multipartFormData: { _ in

        }, with: routing, encodingCompletion: { [weak self] encodingResult in
            switch encodingResult {
                case .success(let upload, _, _):
                    upload.validate()
                    upload.responseData { responseData in
                        switch responseData.result {
                            case .success:
                                if let data = responseData.data {
                                    do {
                                        let mapping = try JSONDecoder().decode(WeatherDataResponce.self, from: data)
                                        completion(mapping, nil)
                                    } catch {
                                        completion(nil, error)
                                    }
                                }
                            case .failure(let error):
                                    completion(nil, error)
                        }
                    }
                case .failure(let encodingError):
                    completion(nil, encodingError)
            }
        })
    }
}
