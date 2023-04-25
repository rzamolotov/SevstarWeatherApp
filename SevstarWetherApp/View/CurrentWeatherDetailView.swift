//
//  CurrentWeatherDetailView.swift
//  SevstarWetherApp
//
//  Created by Роман Замолотов on 25.04.2023.
//

import Foundation
import UIKit

class CurrentWeatherDetailView: UIView {
    
    let currentTime: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "-- ------ ----"
        view.font = .systemFont(ofSize: CGFloat(screenHeight * 0.025))
        view.textAlignment = .center
        view.textColor = .black
        view.layer.opacity = 0.9
        return view
    }()
    
    let weatherSymbol: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "sun.max")
        image.tintColor = .black
        image.contentMode = .scaleAspectFit
        image.widthAnchor.constraint(equalToConstant: CGFloat(screenWidth * 0.3)).isActive = true
        image.heightAnchor.constraint(equalToConstant: CGFloat(screenHeight * 0.2)).isActive = true
        image.layer.opacity = 0.9
        return image
    }()
    
    let temperatureLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "---"
        view.textAlignment = .center
        view.textColor = .black
        view.font = .systemFont(ofSize: CGFloat(screenHeight * 0.07))
        view.layer.opacity = 0.9
        return view
    }()
    
    let feelsLikeDegrees: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "---"
        view.font = .systemFont(ofSize: CGFloat(screenHeight * 0.02))
        view.textAlignment = .center
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
        let backgroundImage = UIImage(named: "weatherBackgroundImage")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.layer.cornerRadius = 15
        backgroundImageView.layer.masksToBounds = true
        addSubview(backgroundImageView)
        
        NSLayoutConstraint.activate([
            backgroundImageView.widthAnchor.constraint(equalToConstant: screenWidth),
            backgroundImageView.heightAnchor.constraint(equalToConstant: screenHeight)
        ])
        
        backgroundImageView.addSubview(currentTime)
        backgroundImageView.addSubview(weatherSymbol)
        backgroundImageView.addSubview(temperatureLabel)
        backgroundImageView.addSubview(feelsLikeDegrees)
        
        NSLayoutConstraint.activate([
            // currentWeatherStackView
            currentTime.leadingAnchor.constraint(equalTo: leadingAnchor),
            currentTime.trailingAnchor.constraint(equalTo: trailingAnchor),
            currentTime.topAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: screenHeight * 0.1),
            
            // weatherSymbol
            weatherSymbol.centerXAnchor.constraint(equalTo: centerXAnchor),
            weatherSymbol.topAnchor.constraint(equalTo: currentTime.bottomAnchor, constant: screenHeight * 0.003),
            
            // temperatureLabel
            temperatureLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            temperatureLabel.topAnchor.constraint(equalTo: weatherSymbol.bottomAnchor, constant: screenHeight * 0.003),
            
            // currentWeatherStackView
            feelsLikeDegrees.leadingAnchor.constraint(equalTo: leadingAnchor),
            feelsLikeDegrees.trailingAnchor.constraint(equalTo: trailingAnchor),
            feelsLikeDegrees.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor,  constant: screenHeight * 0.003)
        ])
    }
}
