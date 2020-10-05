
import UIKit
import CoreData
import Alamofire

protocol WeatherOfCityViewProtocol {
    func reloadData()
}

protocol WeatherOfCityPresenterProtocol {
    func getCityName() -> String
    func reloadData()
    func getCount() -> Int
    func getData(index:Int) -> AllParametersOfWeather
}

class WeatherOfCityPresenter {
    private var router:WeatherOfCityRouter
    private var cityNameString:String
    private var view: WeatherOfCityViewProtocol
    let network : NetworkServiceProtocol = DI.resolve()
    var weathers = [AllParametersOfWeather]()
    let context  = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    init(view: WeatherOfCityViewProtocol, router:WeatherOfCityRouter, name:String) {
        self.cityNameString =  name
        self.router = router
        self.view = view
    }
    func downloadData(with city: String) {
        network.getDataOfCity(city: city, completion: { weatherData, error in
            if error == nil {
                self.weathers = weatherData?.list ?? []
                self.view.reloadData()
            }
        })
    }
    var weatherData = [AllParameters]()

    func saveLocalData (at indexPath: IndexPath) {
        let save = DetailWeather(context: context)
        save.dtTxt = weatherData[indexPath.row].dtTxt
        save.feelsLike = weatherData[indexPath.row].main.feelsLike
        save.temp = weatherData[indexPath.row].main.temp
        save.id = Int64(weatherData[indexPath.row].weather[0].id)
        if context.hasChanges {
            do {
                try  context.save()
                print("done!")
            } catch {
                context.rollback()
                print("error saving context: \(error)")
            }

            //self.tableView.reloadData()
        }
    }
    func loadLocalData(with request:NSFetchRequest<DetailWeather> = DetailWeather.fetchRequest()) {
        do {
            let offLine =  try context.fetch(request)
            //weathers.removeAll()
            for weather in offLine {

            }
            //weathers =  try context.fetch(request)
        } catch {
            print("error fetching data from context:\(error)")
        }
        self.view.reloadData()
    }
}

extension WeatherOfCityPresenter: WeatherOfCityPresenterProtocol {
    func getCount() -> Int {
        return weathers.count
    }
    func getData(index: Int) -> AllParametersOfWeather {
        return weathers[index]
    }
    func reloadData() {
        downloadData(with: cityNameString)
    }
    func getCityName() -> String {
        return cityNameString
    }
}
