//
//  IntExtention.swift
//  SevstarWetherApp
//
//  Created by Роман Замолотов on 22.04.2023.
//

import Foundation

extension Int {
    func incrementWeekDays(by num: Int) -> Int {
        let incrementedVal = self + num
        let mod = incrementedVal % 7
        
        return mod
    }
}
