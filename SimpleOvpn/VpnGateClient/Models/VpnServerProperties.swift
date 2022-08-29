//
//  VpnServerProperties.swift
//  SimpleOvpn
//
//  Created by Kim Long on 25/08/2022.
//

import Foundation

struct VpnServerProperties: Decodable {
    let hostName: String
    let ipAddress: String
    let score: Int64
    let ping: Int64
    let speed: Int64
    let country: String?
    let countryCode: String?
    let operatorName: String?
    let ovpnData: Data

    enum CodingKeys: String, CodingKey {
        case hostName = "#HostName"
        case ipAddress = "IP"
        case score = "Score"
        case ping = "Ping"
        case speed = "Speed"
        case country = "CountryLong"
        case countryCode = "CountryShort"
        case operatorName = "Operator"
        case ovpnData = "OpenVPN_ConfigData_Base64"
    }
}
