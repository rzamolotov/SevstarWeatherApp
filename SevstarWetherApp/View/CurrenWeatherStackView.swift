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
        view.font = .systemFont(ofSize: CGFloat(UIScreen.main.bounds.height * 0.025))
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
        image.widthAnchor.constraint(equalToConstant: CGFloat(UIScreen.main.bounds.width * 0.25)).isActive = true
        image.heightAnchor.constraint(equalToConstant: CGFloat(UIScreen.main.bounds.height * 0.12)).isActive = true
        image.layer.opacity = 0.9
        return image
    }()
    
    let temperatureLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "---"
        view.textAlignment = .center
        view.textColor = .white
        view.font = .systemFont(ofSize: CGFloat(UIScreen.main.bounds.height * 0.04))
        view.layer.opacity = 0.9
        return view
    }()
    
    let feelsLikeDegrees: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "---"
        view.font = .systemFont(ofSize: CGFloat(UIScreen.main.bounds.height * 0.02))
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
        let backgroundImage = UIImage(named: "weatherBackgroundImage")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.layer.cornerRadius = 15
        backgroundImageView.layer.masksToBounds = true
        addSubview(backgroundImageView)
        
        // Add constraints to the background image view
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.95),
            backgroundImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.25)
            
        ])
        
        backgroundImageView.addSubview(currentTime)
        backgroundImageView.addSubview(weatherSymbol)
        backgroundImageView.addSubview(temperatureLabel)
        backgroundImageView.addSubview(feelsLikeDegrees)
        
        NSLayoutConstraint.activate([
            // currentWeatherStackView
            currentTime.leadingAnchor.constraint(equalTo: leadingAnchor),
            currentTime.trailingAnchor.constraint(equalTo: trailingAnchor),
            currentTime.topAnchor.constraint(equalTo: backgroundImageView.topAnchor, constant: UIScreen.main.bounds.height * 0.001),
            
            // weatherSymbol
            weatherSymbol.leadingAnchor.constraint(equalTo: leadingAnchor),
            weatherSymbol.trailingAnchor.constraint(equalTo: trailingAnchor),
            weatherSymbol.topAnchor.constraint(equalTo: currentTime.bottomAnchor, constant: UIScreen.main.bounds.height * 0.01),
            
            // temperatureLabel
            temperatureLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            temperatureLabel.topAnchor.constraint(equalTo: weatherSymbol.bottomAnchor, constant: UIScreen.main.bounds.height * 0.005),
            
            // currentWeatherStackView
            feelsLikeDegrees.leadingAnchor.constraint(equalTo: leadingAnchor),
            feelsLikeDegrees.trailingAnchor.constraint(equalTo: trailingAnchor),
            feelsLikeDegrees.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor,  constant: UIScreen.main.bounds.height * 0.005)
        ])
    }
}
