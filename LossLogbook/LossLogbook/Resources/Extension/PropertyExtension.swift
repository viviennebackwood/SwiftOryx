//
//  PropertyExtension.swift
//  LossLogbook
//
//  Created by Illia Rahozin on 26.08.2023.
//

import Foundation

extension Optional where Wrapped: Numeric {
    static func += (lhs: inout Wrapped?, rhs: Wrapped?) {
        lhs = (lhs ?? 0) + (rhs ?? 0)
    }
}


extension Date {
    func toString(format: String = "yyyy-MM-dd") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
