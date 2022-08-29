//
//  UIApplication+Container.swift
//  SimpleOvpn
//
//  Created by Kim Long on 23/08/2022.
//

import Foundation
import Swinject
import UIKit

extension UIApplication {
    var container: Container {
        // Delegate is guaranteed to be AppDelegate
        // swiftlint:disable force_cast
        (delegate as! AppDelegate).container
    }
}
