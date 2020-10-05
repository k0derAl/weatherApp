import Foundation
struct WeatherData: Codable {
      let list: [AllParameters]
}

struct AllParameters: Codable {
    let dtTxt: String
    let main: Main
    let weather: [Weather]

    public enum CodingKeys: String, CodingKey {
        case dtTxt  = "dt_txt"
        case main
        case weather

    }

}
struct Main: Codable {
     let temp: Double
     let feelsLike: Double

    public enum CodingKeys: String, CodingKey {
        case feelsLike  = "feels_like"
        case temp
    }
}
struct Weather: Codable {
    let id: Int
}
