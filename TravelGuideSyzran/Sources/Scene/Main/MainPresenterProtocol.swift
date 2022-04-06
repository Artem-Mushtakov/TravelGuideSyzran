//
//  MainPresenterProtocol.swift
//  TravelGuideSyzran
//
//  Created by Artem Mushtakov on 06.04.2022.
//

import Foundation


protocol MainPresenterProtocolOutputProtocol: AnyObject {
    func get()
}

protocol MainPresenterProtocolInputProtocol {
    init(view: MainPresenterProtocolOutputProtocol)
}

