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
        label.textColor = .label
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 38, weight: .heavy)
        return label
    }()
    
    let currentTime: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "28 March 2020"
        label.textAlignment = .left
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 10, weight: .heavy)
        return label
    }()
    
    let currentTemperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "°C"
        label.textColor = .label
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
        label.textColor = .label
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
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    let minTemp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "  °C"
        label.textAlignment = .left
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    func setupViews() {
        addSubview(currentLocation)
        addSubview(currentTemperatureLabel)
        addSubview(tempSymbol)
        addSubview(tempDescription)
        addSubview(currentTime)
        addSubview(minTemp)
        addSubview(maxTemp)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        currentLocation.topAnchor.constraint(equalTo: topAnchor, constant: 20)
        currentLocation.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18)
        currentLocation.heightAnchor.constraint(equalToConstant: 70)
        currentLocation.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18)
        
        currentTime.topAnchor.constraint(equalTo: currentLocation.bottomAnchor, constant: 4)
        currentTime.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18)
        currentTime.heightAnchor.constraint(equalToConstant: 10)
        currentTime.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18)
        
        currentTemperatureLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -20)
        currentTemperatureLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18)
        currentTemperatureLabel.heightAnchor.constraint(equalToConstant: 70)
        currentTemperatureLabel.widthAnchor.constraint(equalToConstant: 250)
        
        tempSymbol.topAnchor.constraint(equalTo: currentTemperatureLabel.bottomAnchor)
        tempSymbol.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18)
        tempSymbol.heightAnchor.constraint(equalToConstant: 50)
        tempSymbol.widthAnchor.constraint(equalToConstant: 50)
        
        tempDescription.topAnchor.constraint(equalTo: currentTemperatureLabel.bottomAnchor, constant: 12.5)
        tempDescription.leadingAnchor.constraint(equalTo: tempSymbol.trailingAnchor, constant: 8)
        tempDescription.heightAnchor.constraint(equalToConstant: 20)
        tempDescription.widthAnchor.constraint(equalToConstant: 250)
        
        minTemp.topAnchor.constraint(equalTo: tempSymbol.bottomAnchor, constant: 80)
        minTemp.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18)
        minTemp.heightAnchor.constraint(equalToConstant: 20)
        minTemp.widthAnchor.constraint(equalToConstant: 100)
        
        maxTemp.topAnchor.constraint(equalTo: minTemp.bottomAnchor)
        maxTemp.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18)
        maxTemp.heightAnchor.constraint(equalToConstant: 20)
        maxTemp.widthAnchor.constraint(equalToConstant: 100)
        
    }
}
