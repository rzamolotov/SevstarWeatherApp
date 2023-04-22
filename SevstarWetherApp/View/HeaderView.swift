//
//  HeaderView.swift
//  SevstarWetherApp
//
//  Created by Роман Замолотов on 21.04.2023.
//

import UIKit

final class HeaderView: UIView {
    
    private var fontSize: CGFloat
    
    lazy var headingLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "---" //TODO: город прогноза погоды
        view.font = UIFont.boldSystemFont(ofSize: fontSize)
        view.textColor = .black
        view.layer.opacity = 0.9
        return view
    }()
    
    private lazy var headerStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [headingLabel])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        return view
    }()
    
    init(fontSize: CGFloat) {
        self.fontSize = fontSize
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(headerStackView)
        setupConstrains()
    }
    
    func setupConstrains() {
        //Header
        NSLayoutConstraint.activate([
            headerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerStackView.topAnchor.constraint(equalTo: topAnchor)
        ])
    }
    
}
