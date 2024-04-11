//
//  TaskCheckButton.swift
//  MyToDos-MVVM
//
//  Created by Julia Gurbanova on 11.04.2024.
//

import UIKit

class TaskCheckButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        setButtonChecked(false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func isChecked(_ checked: Bool) {
        setButtonChecked(checked)
    }

    func setButtonChecked(_ checked: Bool) {
        let icon = UIImage(systemName: checked ? "checkmark.circle.fill" : "circle")?
            .withTintColor(.mainCoral, renderingMode: .alwaysOriginal)
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 20.0))
        setImage(icon, for: .normal)
    }
}
