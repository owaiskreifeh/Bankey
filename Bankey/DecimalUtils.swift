//
//  DecimalUtils.swift
//  Bankey
//
//  Created by Owais Kreifeh on 18/06/2022.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        NSDecimalNumber(decimal: self).doubleValue
    }
}
