//
//  HttpClient.swift
//  SimpleOvpn
//
//  Created by Kim Long on 27/08/2022.
//

import Alamofire
import Foundation

typealias URLConvertible = Alamofire.URLConvertible
typealias HttpClientError = Alamofire.AFError

protocol HttpClient {
    func requestData(from convertible: URLConvertible) async -> Result<Data, HttpClientError>
}

struct AFHttpClient: HttpClient {

    static let shared = AFHttpClient()

    private let session: Session

    init(session: Session = .default) {
        self.session = session
    }

    func requestData(from convertible: URLConvertible) async -> Result<Data, HttpClientError> {
        let dataTask = session.request(convertible).serializingData()
        return await dataTask.result
    }
}
