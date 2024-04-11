//
//  PageLabel.swift
//  MyToDos-MVVM
//
//  Created by Julia Gurbanova on 07.04.2024.
//

import UIKit

class PageLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }

    required init(title: String) {
        super.init(frame: .zero)
        configure()
        setTitle(title)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        textAlignment = .center
        font = .systemFont(ofSize: 40, weight: .light)
        textColor = .grayText
    }

    func setTitle(_ title: String) {
        text = title
    }
}
