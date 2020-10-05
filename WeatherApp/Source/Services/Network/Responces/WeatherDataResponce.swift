
import Foundation
struct WeatherDataResponce: Codable {
    let list: [AllParametersOfWeather]
}

struct AllParametersOfWeather: Codable {
    let dtTxt: String
    let main: MainInfo
    let weather: [WeatherDataInfo]

    public enum CodingKeys: String, CodingKey {
        case dtTxt  = "dt_txt"
        case main
        case weather

    }

}
struct MainInfo: Codable {
    let temp: Double
    let feelsLike: Double

    public enum CodingKeys: String, CodingKey {
        case feelsLike  = "feels_like"
        case temp
    }
}
struct WeatherDataInfo: Codable {
    let id: Int
}
