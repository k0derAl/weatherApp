

import UIKit
import CoreData
import Alamofire
class WeatherOfCityVC: UITableViewController {
    var presenter:WeatherOfCityPresenterProtocol?

    let myRefreshControl : UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)) , for: .valueChanged)
        return refreshControl
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = presenter?.getCityName()
        tableView.rowHeight = 291
        tableView.refreshControl = myRefreshControl
    }
    override func viewWillAppear(_ animated: Bool) {
        presenter?.reloadData()
    }
    @objc private func refresh(sender: UIRefreshControl) {
        tableView.reloadData()
        sender.endRefreshing()
    }
    // MARK: - Table view Manipulations
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getCount() ??  0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailWeatherCell") as! DetailWeatherViewCell
        if let data = presenter?.getData(index: indexPath.row) {
            cell.timeLabel.text = data.dtTxt
            cell.temperatureLabel.text = String(format: "%.1f", data.main.temp)
            cell.feelsLikeLabel.text = String(format: "%.1f", data.main.feelsLike)
            // cell.feelsLikeLabel.text = String(format: "%.1f", weatherData[indexPath.row].main.feels_like)
            var conditionId = data.weather[0].id
            var conditionName :String {
                switch conditionId {
                    case 200...232:
                        return  "cloud.bold.rain"
                    case 300...321:
                        return "cloud.drizzle"
                    case 400...531:
                        return "cloud.rain"
                    case 600...622 :
                        return "cloud.snow"
                    case 701...781:
                        return "cloud.fog"
                    case 800:
                        return "sun.max"
                    case 801...804:
                        return "cloud.sun"
                    default:
                        return "cloud"
                }
            }
            print(conditionName)

            cell.symbolImage.image = UIImage(named: conditionName)
        }
        return cell
    }

}
// MARK: - parsing Json and getting data
extension WeatherOfCityVC {

}

extension WeatherOfCityVC: WeatherOfCityViewProtocol {
    func reloadData() {
        tableView.reloadData()
    }

}
