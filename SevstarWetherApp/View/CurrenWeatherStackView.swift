//
//  CurrenWeatherStack.swift
//  SevstarWetherApp
//
//  Created by Роман Замолотов on 22.04.2023.
//

import UIKit

final class CurrenWeatherStackView: UIView {
    
    private lazy var temperatureLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "7C"
        view.font = .boldSystemFont(ofSize: 30)
        return view
    }()
    
    private lazy var feelsLikeLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "ощущается как 7С"
        view.font = .boldSystemFont(ofSize: 20)
        view.textColor = .black
        view.layer.opacity = 0.9
        return view
    }()
    
    private lazy var currentWeatherStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [temperatureLabel, feelsLikeLabel])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
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
        addSubview(currentWeatherStackView)
        setupConstrains()
    }
    
    func setupConstrains() {
        NSLayoutConstraint.activate([
            currentWeatherStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            currentWeatherStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            currentWeatherStackView.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
}
