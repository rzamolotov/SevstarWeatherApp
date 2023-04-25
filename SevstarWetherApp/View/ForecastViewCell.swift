//
//  ForecastViewCell.swift
//  SevstarWetherApp
//
//  Created by Роман Замолотов on 25.04.2023.
//

import Foundation
import UIKit

final class ForecastViewCell: UITableViewCell {
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.backgroundColor = .gray.withAlphaComponent(0.4)
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
        //Header
        NSLayoutConstraint.activate([
            //dateLabel
            dateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            dateLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: screenHeight * 0.008),
            
            weatherSymbol.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            weatherSymbol.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            weatherSymbol.topAnchor.constraint(equalTo: dateLabel.topAnchor, constant: (screenHeight * 0.15) / 3) ,
            
            tempLabel.topAnchor.constraint(equalTo: weatherSymbol.bottomAnchor, constant: screenHeight * 0.01),
            tempLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            tempLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            tempLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}
