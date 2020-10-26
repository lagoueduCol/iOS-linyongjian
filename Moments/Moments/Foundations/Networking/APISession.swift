//
//  APISession.swift
//  Moments
//
//  Created by Jake Lin on 25/10/20.
//

import Foundation
import Alamofire
import RxSwift

public enum APISessionError: Error {
    case networkError(error: Error, statusCode: Int)
    case invalidJSON
    case noData
}

protocol APISession {
    associatedtype ModelType: Codable

    var defaultHeaders: HTTPHeaders { get }

    func post(_ path: String, parameters: Parameters?, headers: HTTPHeaders) -> Observable<ModelType>
}

extension APISession {
    var defaultHeaders: HTTPHeaders {
        // swiftlint:disable no_hardcoded_strings
        let headers: HTTPHeaders =  [
            "x-app-platform": "iOS",
            "x-app-version": UIApplication.appVersion,
            "x-os-version": UIDevice.current.systemVersion
        ]

        return headers
    }

    var baseUrl: URL {
        return API.baseURL
    }

    func post(_ path: String, parameters: Parameters? = nil, headers: HTTPHeaders = [:]) -> Observable<ModelType> {
        return request(path, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
    }
}

private extension APISession {
    func request(_ path: String, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders) -> Observable<ModelType> {
        let url = baseUrl.appendingPathComponent(path)
        var allHeaders = defaultHeaders
        headers.forEach { allHeaders.add($0) }

        return Observable.create { observer -> Disposable in
            let request = AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: allHeaders, interceptor: nil, requestModifier: nil)
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        guard let data = response.data else {
                            // if no error provided by Alamofire return .noData error instead.
                            observer.onError(response.error ?? APISessionError.noData)
                            return
                        }
                        do {
                            let model = try JSONDecoder().decode(ModelType.self, from: data)
                            observer.onNext(model)
                            observer.onCompleted()
                        } catch {
                            observer.onError(error)
                        }
                    case .failure(let error):
                        if let statusCode = response.response?.statusCode {
                            observer.onError(APISessionError.networkError(error: error, statusCode: statusCode))
                        } else {
                            observer.onError(error)
                        }
                    }
                }

            return Disposables.create {
                request.cancel()
            }
        }
    }
}
