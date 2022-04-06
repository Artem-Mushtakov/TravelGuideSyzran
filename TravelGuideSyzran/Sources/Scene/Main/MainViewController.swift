//
//  MainViewController.swift
//  TravelGuideSyzran
//
//  Created by Artem Mushtakov on 05.04.2022.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - UIElements

    private lazy var headerView = UIView().then {
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .systemCyan
        $0.layer.cornerRadius = 16
        $0.layer.shadowColor = UIColor.gray.cgColor.copy(alpha: 0.7)
        $0.layer.shadowOffset = CGSize(width: 0, height: 8)
        $0.layer.shadowRadius = 8
        $0.layer.shadowOpacity = 1
        $0.layer.masksToBounds = false
    }

    private lazy var toDayLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 17)
        $0.textColor = .white
        $0.text = "Погода"
    }

    // MARK: - Setup view

    fileprivate func setupView() {
        view.addSubview(headerView)
        headerView.addSubview(toDayLabel)
        setupNavigationTitle()
        setupConstraints()
    }

    fileprivate func setupConstraints() {

        headerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(150)
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.height.equalTo(100)
        }

        toDayLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().offset(10)
        }
    }

    fileprivate func setupNavigationTitle() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        title = "Главная"
    }
}
