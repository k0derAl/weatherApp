

import Foundation

class WeatherOfCityRouter {
    private var view: WeatherOfCityViewProtocol
    init(_ view: WeatherOfCityViewProtocol) {
        self.view = view
    }
}
