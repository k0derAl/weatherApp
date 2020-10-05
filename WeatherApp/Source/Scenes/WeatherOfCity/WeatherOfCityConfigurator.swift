

import Foundation

import Foundation
import UIKit

class WeatherOfCityConfigurator {
    func configure(
        view: WeatherOfCityVC, name:String) {
        let router = WeatherOfCityRouter(view)
        let presenter = WeatherOfCityPresenter(view: view, router: router, name: name)
        view.presenter = presenter
    }
    static func open(navigationController: UINavigationController, name:String) {
        let view = R.storyboard.weatherOfCity.weatherOfCityVC()!
        //let view = ChatViewController(titleChat: titleChat)
        WeatherOfCityConfigurator().configure(
            view: view, name: name)

        navigationController.navigationItem.hidesBackButton = false
        navigationController.pushViewController(view, animated: true)
    }
}
