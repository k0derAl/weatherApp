

import Foundation
class ListCitiesRouter {
    private var view: ListCitiesVC
    init(_ view: ListCitiesVC) {
        self.view = view
    }

    func openCity(name:String) {
        WeatherOfCityConfigurator.open(navigationController: view.navigationController!, name: name)
    }
}
