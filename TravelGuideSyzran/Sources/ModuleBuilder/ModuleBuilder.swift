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
        let view = MainViewController()
        view.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        return view
    }

    static func createMapModule() -> UIViewController {
        let view = MapViewController()
        view.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        return view
    }

    static func createPopularModule() -> UIViewController {
        let view = PopularViewController()
        view.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 2)
        return view
    }

    static func createFavoritesModule() -> UIViewController {
        let view = FavoritesViewController()
        view.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 3)
        return view
    }
}
