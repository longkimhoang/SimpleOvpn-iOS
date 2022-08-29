//
//  UserDefaults+Extensions.swift
//  SimpleOvpn
//
//  Created by Kim Long on 27/08/2022.
//

import Foundation

extension UserDefaults {
    enum Keys {
        static let stubsEnabled = "com.longkimhoang.SimpleOvpn.StubsEnabled"
    }

    var stubsEnabled: Bool {
        #if DEBUG
            bool(forKey: Keys.stubsEnabled)
        #else
            false
        #endif
    }
}
