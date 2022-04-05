//
//  FavoritesViewController.swift
//  TravelGuideSyzran
//
//  Created by Artem Mushtakov on 05.04.2022.
//

import UIKit

class FavoritesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Избранные"
    }
}
