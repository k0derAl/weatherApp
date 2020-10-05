import UIKit
import CoreData
class ListCitiesVC: SwipeTableViewController {
    var presenter:ListCitiesPresenterProtocol?
    var textField = UITextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        if presenter == nil {
            ListCitiesConfigurator().configure(view: self)
        }
        tableView.rowHeight = 80
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(path)
    }
    @IBAction func addCityButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: R.string.locale.addNewCity(), message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add City", style: .default) { ( _) in
            self.presenter?.addCity(name: self.textField.text!)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addTextField { (field) in
            field.placeholder = "Add new city"
            self.textField = field
        }
        alert.addAction(action)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (presenter?.getCountCity()) ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = presenter!.getCity(index: indexPath.row)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.openCity(index: indexPath.row)
    }

    override func updateModel(at indexPath: IndexPath) {
        presenter?.delete(index: indexPath.row)
    }
}

extension ListCitiesVC: ListCitiesViewProtocol {
    func realoadData() {
        tableView.reloadData()
    }

}
