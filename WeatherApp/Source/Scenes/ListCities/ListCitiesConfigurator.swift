

import Foundation
import UIKit

class ListCitiesConfigurator {
    func configure(
                   view: ListCitiesVC) {
        let router = ListCitiesRouter(view)
        let presenter = ListCitiesPresenter(view: view, router: router)
        view.presenter = presenter
    }
    static func open(navigationController: UINavigationController) {
        let view = ListCitiesVC()
        //let view = ChatViewController(titleChat: titleChat)
        ListCitiesConfigurator().configure(

            view: view)

        navigationController.navigationItem.hidesBackButton = false
        navigationController.pushViewController(view, animated: true)
    }
}
