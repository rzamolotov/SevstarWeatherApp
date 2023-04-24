//
//  HourlyCollectionViewCell.swift
//  SevstarWetherApp
//
//  Created by Роман Замолотов on 24.04.2023.
//

import Foundation
import UIKit

class HourlyCollectionViewCell: UICollectionViewCell{
    
    static let reuseId = "HourlyCollectionViewCell"
    
    //MARK: - variables
    private var blurEffectView = BlurEffect()
    
    private var dateLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 18)
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
        image.widthAnchor.constraint(equalToConstant: CGFloat(screenWidth * 0.12)).isActive = true
        image.heightAnchor.constraint(equalToConstant: CGFloat(screenHeight * 0.06)).isActive = true
        image.layer.opacity = 0.9
        return image
    }()
    
    private var tempLabel: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 20)
        view.textAlignment = .center
        view.textColor = .black
        return view
    }()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        contentView.addSubview(blurEffectView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(weatherSymbol)
        contentView.addSubview(tempLabel)
        
        makeConstraints()
    }
    
    //MARK: - layoutSubviews
    override func layoutSubviews() {
        super.layoutSubviews()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
    }
    
    //MARK: - constraints
    private func makeConstraints(){
        NSLayoutConstraint.activate([
        // blurEffectView
        blurEffectView.topAnchor.constraint(equalTo: topAnchor),
        blurEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
        blurEffectView.trailingAnchor.constraint(equalTo: trailingAnchor),
        blurEffectView.bottomAnchor.constraint(equalTo: bottomAnchor),
        
        // dateLabel
        dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 18),
        dateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        
        // weatherSymbol
        weatherSymbol.centerYAnchor.constraint(equalTo: centerYAnchor),
        weatherSymbol.centerXAnchor.constraint(equalTo: centerXAnchor),
        
        // tempLabel
        tempLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -18),
        tempLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
