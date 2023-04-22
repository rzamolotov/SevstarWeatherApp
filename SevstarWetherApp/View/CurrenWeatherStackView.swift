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
        view.text = "-- ------ ----"
        view.font = .boldSystemFont(ofSize: 15)
        view.textAlignment = .center
        view.textColor = .black
        return view
    }()
    
    let weatherSymbol: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "sun.max")
        image.contentMode = .scaleAspectFit
        image.tintColor = .gray
        image.widthAnchor.constraint(equalToConstant: 300).isActive = true
        image.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return image
    }()
    
    let temperatureLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "---"
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 15)
        return view
    }()
    
    let degreesLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "°C"
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 15)
        return view
    }()
    
    let feelsLikeLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "ощущается как"
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 10)
        
        view.textColor = .black
        view.layer.opacity = 0.9
        return view
    }()
    
    let feelsLikeDegrees: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "---"
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 10)
        view.textColor = .black
        view.layer.opacity = 0.9
        return view
    }()
    
    let feelsLikeDegreesLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "---"
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 10)
        view.textColor = .black
        view.layer.opacity = 0.9
        return view
    }()
    
    lazy var feelsLikeStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [feelsLikeLabel, feelsLikeDegrees, feelsLikeDegreesLabel])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        return view
    }()
    
    lazy var currentWeatherStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [currentTime, weatherSymbol, temperatureLabel, feelsLikeStackView])
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
            currentWeatherStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            currentWeatherStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            currentWeatherStackView.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
}
