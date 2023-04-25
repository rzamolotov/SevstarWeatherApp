//
//  CurrenWeatherStack.swift
//  SevstarWetherApp
//
//  Created by Роман Замолотов on 22.04.2023.
//

import UIKit

class CurrenWeatherStackView: UIView {
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let backgroundImageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "weatherBackgroundImage"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 15
        image.layer.masksToBounds = true
        return image
    }()
    
    let currentTime: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "-- ------ ----"
        view.font = .systemFont(ofSize: CGFloat(screenHeight * 0.025))
        view.textAlignment = .center
        view.textColor = .white
        view.layer.opacity = 0.9
        return view
    }()
    
    let weatherSymbol: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "sun.max")
        image.tintColor = .white
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
        view.textColor = .white
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
        view.textColor = .white
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
        addSubview(containerView)
        containerView.addSubview(backgroundImageView)
        containerView.addSubview(currentTime)
        containerView.addSubview(weatherSymbol)
        containerView.addSubview(temperatureLabel)
        containerView.addSubview(feelsLikeDegrees)
        setupConstraints()
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.widthAnchor.constraint(equalToConstant: screenWidth * 0.95),
            containerView.heightAnchor.constraint(equalToConstant: screenHeight * 0.35),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundImageView.widthAnchor.constraint(equalToConstant: screenWidth * 0.95),
            backgroundImageView.heightAnchor.constraint(equalToConstant: screenHeight * 0.35)
        ])
        
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // currentWeatherStackView
                        currentTime.leadingAnchor.constraint(equalTo: leadingAnchor),
                        currentTime.trailingAnchor.constraint(equalTo: trailingAnchor),
                        currentTime.topAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: screenHeight * 0.001),
                        
                        // weatherSymbol
                        weatherSymbol.centerXAnchor.constraint(equalTo: centerXAnchor),
                        weatherSymbol.topAnchor.constraint(equalTo: currentTime.bottomAnchor, constant: screenHeight * 0.001),
                        
                        // temperatureLabel
                        temperatureLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                        temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                        temperatureLabel.topAnchor.constraint(equalTo: weatherSymbol.bottomAnchor, constant: screenHeight * 0.001),
                        
                        // currentWeatherStackView
                        feelsLikeDegrees.leadingAnchor.constraint(equalTo: leadingAnchor),
                        feelsLikeDegrees.trailingAnchor.constraint(equalTo: trailingAnchor),
                        feelsLikeDegrees.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor,  constant: screenHeight * 0.001)
        ])
    }
}

