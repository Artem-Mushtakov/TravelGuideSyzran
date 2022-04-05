//
//  TabBarController.swift
//  TravelGuideSyzran
//
//  Created by Artem Mushtakov on 05.04.2022.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        self.tabBar.barTintColor = .clear
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let items = tabBar.items else { return }

        items[0].title = "Главная"
        items[1].title = "Карта"
        items[2].title = "Популярные"
        items[3].title = "Избранные"

        items[0].image = .actions
        items[1].image = .add
        items[2].image = .checkmark
        items[3].image = .remove
    }
}
