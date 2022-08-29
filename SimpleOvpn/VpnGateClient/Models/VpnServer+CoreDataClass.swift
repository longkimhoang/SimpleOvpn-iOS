//
//  VpnServer+CoreDataClass.swift
//  SimpleOvpn
//
//  Created by Kim Long on 25/08/2022.
//
//

import CoreData

@objc(VpnServer)
public class VpnServer: NSManagedObject {
    func update(from properties: VpnServerProperties) {
        hostName = properties.hostName
        ipAddress = properties.ipAddress
        ping = properties.ping
        speed = properties.speed
        country = properties.country
        countryCode = properties.countryCode
        operatorName = properties.operatorName
        ovpnConfig = properties.ovpnData
    }
}
