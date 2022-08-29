//
//  Logger+Extensions.swift
//  SimpleOvpn
//
//  Created by Kim Long on 27/08/2022.
//

import Foundation
import os

extension Logger {

    enum Constants {
        static let subsystem = "com.longkimhoang.SimpleOvpn"
    }

    init(category: String) {
        self.init(subsystem: Constants.subsystem, category: category)
    }
}
