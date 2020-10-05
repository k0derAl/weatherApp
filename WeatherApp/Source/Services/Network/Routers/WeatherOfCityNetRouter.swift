//
//  WeatherOfCityNetRouter.swift
//  WeatherApp

import Foundation
import Alamofire

class SittintWeatherOfCityNetRouter {
    static let mainPath = "https://api.openweathermap.org/data/2.5/"
    static let apiKey = "6e4cccc00efdf57bfcf1a5a28d53e453"
}

public enum WeatherOfCityNetRouter: URLRequestConvertible {
    case getCityData([String: Any])
    public func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self {
                case
                    .getCityData:
                    return .get
            }
        }
        let params: ([String: Any]?) = {
            switch self {
                case .getCityData(let json):
                    return (json)
            }
        }()
        let url: URL = {
            // build up and return the URL for each endpoint
            let url = URL(string: SittintWeatherOfCityNetRouter.mainPath)!.appendingPathComponent(relativePath)
            return url
        }()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        let encoding: ParameterEncoding = {
            switch method {
                case .get:
                    return URLEncoding.default
                default:
                    return JSONEncoding.default
            }
        }()
        return try encoding.encode(urlRequest, with: params)
    }
    var relativePath: String {
        let path: String
        switch self {
            case .getCityData(let json):
                    path = "forecast"
        }
        return path
    }
}
