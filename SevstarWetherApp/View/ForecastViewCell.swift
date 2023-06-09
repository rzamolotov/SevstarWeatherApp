//
//  ForecastViewCell.swift
//  SevstarWetherApp
//
//  Created by Роман Замолотов on 25.04.2023.
//

import Foundation
import UIKit

class ForecastViewCell: UITableViewCell, UITableViewDataSource {
    
    var hourlyForecast: [WeatherModel.Hourly] = []
    let tableView = UITableView()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.backgroundColor = .gray.withAlphaComponent(0.1)
        return view
    }()
    
    let dateLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = ("---")
        view.font = .systemFont(ofSize: screenHeight * 0.02)
        view.textAlignment = .center
        view.textColor = .black
        return view
    }()
    
    let weatherSymbol: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "sun.max")
        image.tintColor = .black
        image.contentMode = .scaleAspectFit
        image.layer.opacity = 0.9
        return image
    }()
    
    let tempLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: screenHeight * 0.02)
        view.text = ("---")
        view.textAlignment = .center
        view.textColor = .black
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        translatesAutoresizingMaskIntoConstraints = false
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(containerView)
        containerView.addSubview(dateLabel)
        containerView.addSubview(weatherSymbol)
        containerView.addSubview(tempLabel)
        
        setupConstraints()
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.widthAnchor.constraint(equalToConstant: screenWidth * 0.15),
            containerView.heightAnchor.constraint(equalToConstant: screenHeight * 0.15),
            weatherSymbol.widthAnchor.constraint(equalToConstant: screenWidth * 0.1),
            weatherSymbol.heightAnchor.constraint(equalToConstant: screenHeight * 0.05),
        ])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            //dateLabel
            dateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            dateLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: screenHeight * 0.008),
            //weatherSymbol
            weatherSymbol.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            weatherSymbol.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            weatherSymbol.topAnchor.constraint(equalTo: dateLabel.topAnchor, constant: (screenHeight * 0.15) / 3 / 1.1) ,
            //tempLabel
            tempLabel.topAnchor.constraint(equalTo: weatherSymbol.bottomAnchor, constant: screenHeight * 0.01),
            tempLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            tempLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            tempLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hourlyForecast.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:00"
        let currentDate = Date()
        let dateString = dateFormatter.string(from: currentDate)
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath) as! ForecastViewCell
        let hourly = hourlyForecast[indexPath.row]
        cell.dateLabel.text = dateString
        cell.weatherSymbol.image = UIImage(systemName: hourly.conditionName)
        cell.tempLabel.text = "\(hourly.temp) °C"
        return cell
    }
}

extension ForecastViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return screenHeight * 0.07
    }
}
