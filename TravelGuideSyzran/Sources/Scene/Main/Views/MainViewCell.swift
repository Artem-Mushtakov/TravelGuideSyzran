//
//  MainViewCell.swift
//  TravelGuideSyzran
//
//  Created by Artem Mushtakov on 06.04.2022.
//

import UIKit

class MainViewCell: UICollectionViewCell {

    // MARK: - UI elements

    lazy var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }

    // MARK: Setup layout

    private func setupView() {
        setupConstraints()
    }

    private func setupConstraints() {

        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.leading.equalToSuperview().offset(5)
            $0.trailing.equalToSuperview().offset(-5)
            $0.width.equalTo(50)
            $0.height.equalTo(50)
        }
    }
}
