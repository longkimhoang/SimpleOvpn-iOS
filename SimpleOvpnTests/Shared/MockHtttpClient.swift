//
//  MockHtttpClient.swift
//  SimpleOvpnTests
//
//  Created by Kim Long on 27/08/2022.
//

import Foundation

@testable import SimpleOvpn

class MockHttpClient: HttpClient {

    private(set) var url: URLConvertible?
    private(set) var requestDataCalledCount = 0
    var stubbedResponse: Result<Data, HttpClientError>?

    func requestData(from convertible: URLConvertible) async -> Result<Data, HttpClientError> {
        guard let stubbedResponse = stubbedResponse else {
            fatalError("Response stub was not set")
        }

        url = convertible
        requestDataCalledCount += 1
        return stubbedResponse
    }

    func reset() {
        url = nil
        requestDataCalledCount = 0
        stubbedResponse = nil
    }
}
