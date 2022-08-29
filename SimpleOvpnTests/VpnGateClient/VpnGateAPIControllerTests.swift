//
//  VpnGateAPIControllerTests.swift
//  SimpleOvpnTests
//
//  Created by Kim Long on 29/08/2022.
//

import SimpleOvpnStubs
import XCTest

@testable import SimpleOvpn

class VpnGateAPIControllerTests: XCTestCase {

    private let mockHttpClient = MockHttpClient()
    private lazy var controller = VpnGateAPIController(httpClient: mockHttpClient)

    override func tearDown() {
        mockHttpClient.reset()
    }

    func testFetchVpnServers_whenDataIsValid() async throws {
        // Given
        let stubUrl = SimpleOvpnStubs.url(forStubNamed: "vpngate_response_short.txt")
        let mockResponseData = try Data(contentsOf: stubUrl)
        mockHttpClient.stubbedResponse = .success(mockResponseData)

        // When
        let servers = try await controller.fetchVpnServers()

        // Then
        let requestUrl = try XCTUnwrap(mockHttpClient.url as? String)
        XCTAssertEqual(mockHttpClient.requestDataCalledCount, 1)
        XCTAssertEqual(requestUrl, "https://www.vpngate.net/api/iphone")
        XCTAssertEqual(servers.count, 1)
    }

    func testFetchVpnServers_whenDataIsInvalid() async throws {
        // Given
        let mockResponseData = Data()
        mockHttpClient.stubbedResponse = .success(mockResponseData)

        // When
        let task = Task {
            try await controller.fetchVpnServers()
        }
        let result = await task.result

        // Then
        switch result {
        case .failure(VpnGateAPIControllerError.cannotDecodeResponse):
            break
        default:
            XCTFail("Expected invalid data failure")
        }
    }

    func testFetchVpnServers_whenEncounteredHttpError() async throws {
        // Given
        mockHttpClient.stubbedResponse = .failure(.explicitlyCancelled)

        // When
        let task = Task {
            try await controller.fetchVpnServers()
        }
        let result = await task.result

        // Then
        switch result {
        case .failure(VpnGateAPIControllerError.httpClientError(.explicitlyCancelled)):
            break
        default:
            XCTFail("Expected http client failure")
        }
    }
}
