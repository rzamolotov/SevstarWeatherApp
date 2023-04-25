//
//  ForecastContainerView.swift
//  SevstarWetherApp
//
//  Created by Роман Замолотов on 25.04.2023.
//

import Foundation
import UIKit

class ForecastContainerView: UIView {
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.backgroundColor = .gray.withAlphaComponent(0.1)
        return view
    }()
    
    // Заголовок с датой
    let dateTitleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Дата прогноза"
        view.font = .systemFont(ofSize: screenHeight * 0.02)
        view.textAlignment = .left
        view.textColor = .black
        return view
    }()
    
    // Прогноз погоды на дату
    let dateForecast: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Прогноз погоды"
        view.font = .systemFont(ofSize: screenHeight * 0.02)
        view.textAlignment = .right
        view.textColor = .black
        return view
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black.withAlphaComponent(0.8)
        return view
    }()
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsHorizontalScrollIndicator = false
        view.isPagingEnabled = true // включаем перелистывание постранично
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
        setupConstraints()
    }
    
    func setupConstraints() {
        let forecastViewCell = ForecastViewCell()
        
        
        containerView.addSubview(dateTitleLabel)
        containerView.addSubview(lineView)
        containerView.addSubview(dateForecast)
        containerView.addSubview(scrollView)
        scrollView.addSubview(forecastViewCell)
        NSLayoutConstraint.activate([
            // container
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.widthAnchor.constraint(equalToConstant: screenWidth * 0.95),
            containerView.heightAnchor.constraint(equalToConstant: screenHeight * 0.25),
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            // date
            dateTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: screenHeight * 0.02),
            dateTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: screenWidth * 0.05),
            dateTitleLabel.widthAnchor.constraint(equalToConstant: screenWidth * 0.4),
            
            // dateForecast
            dateForecast.topAnchor.constraint(equalTo: containerView.topAnchor, constant: screenHeight * 0.02),
            dateForecast.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -screenWidth * 0.05),
            dateForecast.widthAnchor.constraint(equalToConstant: screenWidth * 0.4),
            
            // line
            lineView.heightAnchor.constraint(equalToConstant: screenHeight * 0.0025),
            lineView.topAnchor.constraint(equalTo: dateTitleLabel.bottomAnchor, constant: screenHeight * 0.02),
            lineView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: screenWidth * 0.05),
            lineView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -screenWidth * 0.05),
            
            // scrollView
            scrollView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: screenWidth * 0.05),
            scrollView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -screenWidth * 0.05),
            scrollView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: screenHeight * 0.02),
            scrollView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -screenHeight * 0.001),
            
            // forecastViewCell
            forecastViewCell.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            forecastViewCell.topAnchor.constraint(equalTo: scrollView.topAnchor),
            forecastViewCell.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            forecastViewCell.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            // задаем ширину scrollView равной ширине forecastViewCell
            scrollView.widthAnchor.constraint(equalTo: forecastViewCell.widthAnchor)
        ])
    }
    
}
