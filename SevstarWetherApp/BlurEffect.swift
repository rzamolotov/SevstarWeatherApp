//
//  BlurEffect.swift
//  SevstarWetherApp
//
//  Created by Роман Замолотов on 24.04.2023.
//

import Foundation
import UIKit

class BlurEffect: UIVisualEffectView{
    
    override init(effect: UIVisualEffect?) {
        super.init(effect: UIBlurEffect(style: .regular))
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.opacity = 0.4
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
