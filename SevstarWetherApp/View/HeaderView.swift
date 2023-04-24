//
//  HeaderView.swift
//  SevstarWetherApp
//
//  Created by Роман Замолотов on 21.04.2023.
//

import UIKit

final class HeaderView: UIView {
    
    let headingLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "---" //TODO: город прогноза погоды
        view.font = .boldSystemFont(ofSize: screenHeight * 0.03)
        view.textColor = .black
        view.layer.opacity = 0.9
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(headingLabel)
        setupConstrains()
    }
    
    func setupConstrains() {
        //Header
        NSLayoutConstraint.activate([
            headingLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            headingLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            headingLabel.topAnchor.constraint(equalTo: topAnchor)
        ])
        
    }
    
}
