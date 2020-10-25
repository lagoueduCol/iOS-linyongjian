//
//  APISession.swift
//  Moments
//
//  Created by Jake Lin on 25/10/20.
//

import Foundation
import RxSwift

typealias Parameters = [String: Any]
typealias HTTPHeaders = [String: String]

public enum APISessionError: Error {
    case networkError
    case invalidJSON
    case noData
}

protocol APISession {
    // swiftlint:disable type_name
    associatedtype T: Codable
    func post(_ path: String, parameters: Parameters?, headers: HTTPHeaders) -> Observable<T>
}

extension APISession {
    var baseUrl: URL {
        return API.baseURL
    }

    func post(_ path: String, parameters: Parameters?, headers: HTTPHeaders) -> Observable<T> {
        return Observable.create { observer -> Disposable in
            let url = baseUrl.appendingPathComponent(path)

            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    observer.onError(error)
                    return
                }

                guard let data = data else {
                    observer.onError(APISessionError.noData)
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse, (200...399).contains(httpResponse.statusCode) else {
                    observer.onError(APISessionError.networkError)
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(T.self, from: data)
                    observer.onNext(model)
                    observer.onCompleted()
                } catch {
                    observer.onError(APISessionError.invalidJSON)
                }
            }
            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
    }
}

private extension APISession {
    func createURLRequest(url: URL, method: String, parameters: Parameters?, headers: HTTPHeaders) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers

        guard let parameters = parameters else {
            return request
        }

        // TODO: enconde `parameters` and recreate `URLRequest`
        return request
    }
}
