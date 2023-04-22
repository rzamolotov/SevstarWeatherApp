//
//  CurrentWeatherBackgroundView.swift
//  SevstarWetherApp
//
//  Created by Роман Замолотов on 21.04.2023.
//

import UIKit

final class CurrentWeatherBackgroundView: UIView {

    let currentLocation: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "...Location"
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 38, weight: .heavy)
        return label
    }()
    
    let currentTime: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "28 March 2020"
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 10, weight: .heavy)
        return label
    }()
    
    let currentTemperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "°C"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 60, weight: .heavy)
        return label
    }()
    
    let tempDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "..."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return label
    }()
    let tempSymbol: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "cloud.fill")
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        img.tintColor = .gray
        return img
    }()
    
    
    let maxTemp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "  °C"
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    let minTemp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "  °C"
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private lazy var weatherStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [currentLocation, currentTemperatureLabel, tempSymbol, tempDescription, currentTime, minTemp, maxTemp])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        return view
    }()
    
    func setupViews() {
//        addSubview(currentLocation)
//        addSubview(currentTemperatureLabel)
//        addSubview(tempSymbol)
//        addSubview(tempDescription)
//        addSubview(currentTime)
//        addSubview(minTemp)
//        addSubview(maxTemp)
        addSubview(weatherStackView)
        setupConstraints()
    }
    
    func setupConstraints() {
        
        weatherStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        weatherStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10).isActive = true
        weatherStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        weatherStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true
        
//        currentLocation.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
//        currentLocation.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18).isActive = true
//        currentLocation.heightAnchor.constraint(equalToConstant: 70).isActive = true
//        currentLocation.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18).isActive = true
//
//        currentTime.topAnchor.constraint(equalTo: currentLocation.bottomAnchor, constant: 4).isActive = true
//        currentTime.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18).isActive = true
//        currentTime.heightAnchor.constraint(equalToConstant: 10).isActive = true
//        currentTime.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18).isActive = true
//
//        currentTemperatureLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20).isActive = true
//        currentTemperatureLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18).isActive = true
//        currentTemperatureLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
//        currentTemperatureLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
//
//        tempSymbol.topAnchor.constraint(equalTo: currentTemperatureLabel.bottomAnchor).isActive = true
//        tempSymbol.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18).isActive = true
//        tempSymbol.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        tempSymbol.widthAnchor.constraint(equalToConstant: 50).isActive = true
//
//        tempDescription.topAnchor.constraint(equalTo: currentTemperatureLabel.bottomAnchor, constant: 12.5).isActive = true
//        tempDescription.leadingAnchor.constraint(equalTo: tempSymbol.trailingAnchor, constant: 8).isActive = true
//        tempDescription.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        tempDescription.widthAnchor.constraint(equalToConstant: 250).isActive = true
//
//        minTemp.topAnchor.constraint(equalTo: tempSymbol.bottomAnchor, constant: 80).isActive = true
//        minTemp.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18).isActive = true
//        minTemp.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        minTemp.widthAnchor.constraint(equalToConstant: 100).isActive = true
//
//        maxTemp.topAnchor.constraint(equalTo: minTemp.bottomAnchor).isActive = true
//        maxTemp.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18).isActive = true
//        maxTemp.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        maxTemp.widthAnchor.constraint(equalToConstant: 100).isActive = true
//
    }
}
