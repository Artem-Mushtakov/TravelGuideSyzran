//
//  ModuleBuilder.swift
//  TravelGuideSyzran
//
//  Created by Artem Mushtakov on 05.04.2022.
//

import UIKit

protocol Builder {
    static func createTabBarModule() -> UIViewController
    static func createMainModule() -> UIViewController
    static func createMapModule() -> UIViewController
    static func createPopularModule() -> UIViewController
    static func createFavoritesModule() -> UIViewController
}

// Сборщик модулей
class ModuleBuilder: Builder {

    static func createTabBarModule() -> UIViewController {
        let view = TabBarController()
        view.viewControllers = [createMainModule(), createMapModule(), createPopularModule(), createFavoritesModule()]
        return view
    }

    static func createMainModule() -> UIViewController {
        let view = UINavigationController(rootViewController: MainViewController())
        return view
    }

    static func createMapModule() -> UIViewController {
        let view = UINavigationController(rootViewController: MapViewController())
        return view
    }

    static func createPopularModule() -> UIViewController {
        let view = UINavigationController(rootViewController: PopularViewController())
        return view
    }

    static func createFavoritesModule() -> UIViewController {
        let view = UINavigationController(rootViewController: FavoritesViewController())
        return view
    }
}
