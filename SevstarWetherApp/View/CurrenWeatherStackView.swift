//
//  CurrenWeatherStack.swift
//  SevstarWetherApp
//
//  Created by Роман Замолотов on 22.04.2023.
//

import UIKit

final class CurrenWeatherStackView: UIView {
    
    let currentTime: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "28 March 2020"
        view.font = .boldSystemFont(ofSize: 20)
        view.textAlignment = .center
        view.textColor = .black
        return view
    }()
    
    let weatherSymbol: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "cloud.fill")
        image.contentMode = .scaleAspectFit
        image.tintColor = .gray
        image.widthAnchor.constraint(equalToConstant: 100).isActive = true
        image.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return image
    }()
    
    let temperatureLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "---"
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 30)
        return view
    }()
    
    let feelsLikeLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "ощущается как 7С"
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 20)
        view.textColor = .black
        view.layer.opacity = 0.9
        return view
    }()
    
    lazy var currentWeatherStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [currentTime, weatherSymbol, temperatureLabel, feelsLikeLabel])
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
