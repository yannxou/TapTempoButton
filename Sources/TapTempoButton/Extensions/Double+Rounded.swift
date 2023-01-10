//
//  Double+Rounded.swift
//  TapTempoButton
//
//  Created by Joan Duat on 13/5/22.
//

import Foundation

extension Double {
    func rounded(toDecimalPlaces n: Int) -> Double {
        let multiplier = pow(10, Double(n))
        return (multiplier * self).rounded() / multiplier
    }
}
