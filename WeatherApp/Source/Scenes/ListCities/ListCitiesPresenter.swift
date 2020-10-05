

import Foundation
import UIKit
import CoreData

protocol ListCitiesViewProtocol {
    func realoadData()
}

protocol ListCitiesPresenterProtocol {
    func delete(index: Int)
    func addCity(name:String)
    func getCity(index:Int) -> String
    func getCountCity() -> Int
    func openCity(index:Int)
}

class ListCitiesPresenter {
    var router:ListCitiesRouter
    var cities = [Cities]()
    var view: ListCitiesViewProtocol
    let context  = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    init(view: ListCitiesViewProtocol, router:ListCitiesRouter) {
        self.router = router
        self.view = view
        loadLocalData()
        insertCity()
    }
    func insertCity() {
        if cities.isEmpty {
            let zero = Cities(context: self.context )
            zero.name = "Moscow"
            self.cities.insert(zero, at: 0)
            let frst = Cities(context: self.context )
            frst.name = "London"
            self.cities.insert(frst, at: 1)
            saveLocalData()
        }
    }
    func saveLocalData () {
        if context.hasChanges {
            do {
                try  context.save()
            } catch {
                context.rollback()
                print("error saving context: \(error)")
            }
            self.view.realoadData()
        }
    }
    func loadLocalData(with request:NSFetchRequest<Cities> = Cities.fetchRequest()) {
        do {
            cities =  try context.fetch(request)
        } catch {
            print("error fetching data from context:\(error)")
        }
        view.realoadData()
    }
}

extension ListCitiesPresenter: ListCitiesPresenterProtocol {
    func openCity(index: Int) {
        router.openCity(name: cities[index].name!)
    }

    func getCountCity() -> Int {
        return cities.count
    }
    func getCity(index: Int) -> String {
        return cities[index].name!
    }
    func delete(index: Int) {
        let city = self.cities[index]
        self.context.delete(city)
        self.cities.remove(at: index)
    }
    func addCity(name: String) {
        let newCity = Cities(context: self.context)
        newCity.name = name
        self.cities.append(newCity)
        self.saveLocalData()
    }
}
