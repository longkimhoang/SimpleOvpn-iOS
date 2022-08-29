//
//  VpnGateAPIController.swift
//  SimpleOvpn
//
//  Created by Kim Long on 24/08/2022.
//

import CSV
import CoreData
import Foundation
import os

enum VpnGateAPIControllerError: Error {
    case httpClientError(HttpClientError)
    case invalidData
    case cannotDecodeResponse(Error)
}

protocol VpnGateAPIControlling {
    func fetchVpnServers() async throws -> [VpnServerProperties]
}

struct VpnGateAPIController: VpnGateAPIControlling {

    private let httpClient: HttpClient
    private let logger = Logger(category: "API")
    private let decoder = CSVRowDecoder()
    private let signposter: OSSignposter

    init(
        httpClient: HttpClient = AFHttpClient()
    ) {
        self.httpClient = httpClient
        self.signposter = OSSignposter(logger: logger)
    }
}

// MARK: Conformance

extension VpnGateAPIController {
    func fetchVpnServers() async throws -> [VpnServerProperties] {
        let requestUrl = createRequestUrl()
        do {
            let data = try await httpClient.requestData(from: requestUrl).get()
            let parseTask = Task {
                try parseResponseData(data)
            }

            return try await parseTask.value
        } catch let error as HttpClientError {
            throw VpnGateAPIControllerError.httpClientError(error)
        }
    }
}

// MARK: Private

extension VpnGateAPIController {
    fileprivate func createRequestUrl() -> some URLConvertible {
        return Constants.vpnGateApiUrlString
    }

    fileprivate func parseResponseData(_ data: Data) throws -> [VpnServerProperties] {
        let signpostId = signposter.makeSignpostID()
        let state = signposter.beginInterval("parseResponseData", id: signpostId)
        defer { signposter.endInterval("parseResponseData", state) }

        guard let responseString = String(data: data, encoding: .utf8) else {
            throw VpnGateAPIControllerError.invalidData
        }

        let lines = responseString.split(whereSeparator: { $0.isNewline })
        let csv =
            lines
            .dropFirst()
            .prefix { !$0.starts(with: "*") }
            .joined(separator: "\n")
        signposter.emitEvent("Prepare CSV data.", id: signpostId)

        do {
            let reader = try CSVReader(string: csv, hasHeaderRow: true)
            return try reader.map { _ in
                try decoder.decode(VpnServerProperties.self, from: reader)
            }
        } catch {
            throw VpnGateAPIControllerError.cannotDecodeResponse(error)
        }
    }
}

// MARK: Constants

extension VpnGateAPIController {
    fileprivate enum Constants {
        static let vpnGateApiUrlString = "https://www.vpngate.net/api/iphone"
    }
}
